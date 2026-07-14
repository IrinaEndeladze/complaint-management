const cds = require("@sap/cds");

module.exports = cds.service.impl(function () {
  const {
    Complaints,
    Customers,
  } = this.entities;

  const {
    Statuses: DbStatuses,
  } = cds.entities("com.mycompany.complaints");

this.before("SAVE", Complaints.drafts, async (req) => {
  const subject = req.data.subject?.trim();
  const description = req.data.description?.trim();

  if (!subject) {
    return req.reject(400, "Complaint subject is required");
  }

  if (!description) {
    return req.reject(400, "Complaint description is required");
  }

  const allowedPriorities = [
    "LOW",
    "MEDIUM",
    "HIGH",
    "CRITICAL",
  ];

  if (
    req.data.priority &&
    !allowedPriorities.includes(req.data.priority)
  ) {
    return req.reject(
      400,
      `Priority must be one of: ${allowedPriorities.join(", ")}`
    );
  }

  const newStatus = await SELECT.one
    .from(DbStatuses)
    .where({ code: "NEW" });

  if (!newStatus) {
    return req.reject(
      500,
      'Default status "NEW" is not configured'
    );
  }

  req.data.subject = subject;
  req.data.description = description;
  req.data.priority ??= "MEDIUM";
  req.data.reportedAt ??= new Date().toISOString();
  req.data.status_ID ??= newStatus.ID;
});

  this.before(["CREATE", "UPDATE"], Customers, (req) => {
    if (!req.data.email) return;

    const email = req.data.email.trim().toLowerCase();
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailPattern.test(email)) {
      req.reject(400, "Customer email address is invalid");
    }
    req.data.email = email;
  });

  this.before("UPDATE", Complaints, async (req) => {
    const complaintId = getEntityId(req);

    if (!complaintId) {
      req.reject(400, "Complaint ID is missing");
    }

    const currentComplaint = await SELECT.one
      .from(Complaints)
      .columns("ID", "status_ID", "resolutionSummary")
      .where({ ID: complaintId });

    if (!currentComplaint) {
      req.reject(404, "Complaint was not found");
    }

const currentStatus = await getStatusById(
  currentComplaint.status_ID
);
    if (
      currentStatus?.code === "CLOSED" &&
      !req.user.is("ComplaintManager")

    ) {
      req.reject(
        403,
        "Closed complaints can only be edited by a Complaint Manager"
      );

    }

    const nextStatusId = req.data.status_ID ?? currentComplaint.status_ID;
    const nextStatus = await getStatusById(nextStatusId);

    const resolutionSummary =
      req.data.resolutionSummary ??
      currentComplaint.resolutionSummary;
    if (
      ["RESOLVED", "CLOSED"].includes(nextStatus?.code) &&
      !resolutionSummary?.trim()
    ) {
      req.reject(
        400,
        "Resolution summary is required before resolving or closing a complaint"
      );

    }

    if (["RESOLVED", "CLOSED"].includes(nextStatus?.code)) {
      req.data.resolvedAt ??= new Date().toISOString();
    }

    if (
      nextStatus?.code === "IN_PROGRESS" &&
      ["RESOLVED", "CLOSED"].includes(currentStatus?.code)
    ) {
      req.data.resolvedAt = null;
    }
  });

async function getStatusById(statusId) {
  if (!statusId) return null;
  return SELECT.one
    .from(DbStatuses)
    .columns("ID", "code", "name", "isFinal")
    .where({ ID: statusId });
}

  function getEntityId(req) {
    const params = req.params?.[0];

    if (typeof params === "string") {
      return params;
    }

    if (params?.ID) {
      return params.ID;
    }
    return req.data.ID;
  }

});