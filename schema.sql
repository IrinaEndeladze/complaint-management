
CREATE TABLE com_mycompany_complaints_Customers (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP_TEXT,
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP_TEXT,
  modifiedBy NVARCHAR(255),
  fisrtName NVARCHAR(80) NOT NULL,
  lastName NVARCHAR(80) NOT NULL,
  email NVARCHAR(150) NOT NULL,
  phone NVARCHAR(30),
  PRIMARY KEY(ID)
);

CREATE TABLE com_mycompany_complaints_Complaints (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP_TEXT,
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP_TEXT,
  modifiedBy NVARCHAR(255),
  subject NVARCHAR(150) NOT NULL,
  description NCLOB NOT NULL,
  priority NVARCHAR(10) DEFAULT 'MEDIUM',
  reportedAt TIMESTAMP_TEXT,
  resolvedAt TIMESTAMP_TEXT,
  resolutionSummary NCLOB,
  customer_ID NVARCHAR(36) NOT NULL,
  product_ID NVARCHAR(36),
  status_ID NVARCHAR(36) NOT NULL,
  PRIMARY KEY(ID)
);

CREATE TABLE com_mycompany_complaints_Products (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP_TEXT,
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP_TEXT,
  modifiedBy NVARCHAR(255),
  name NVARCHAR(120) NOT NULL,
  category NVARCHAR(80),
  serialNumber NVARCHAR(100),
  isActive BOOLEAN DEFAULT TRUE,
  PRIMARY KEY(ID)
);

CREATE TABLE com_mycompany_complaints_Statuses (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP_TEXT,
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP_TEXT,
  modifiedBy NVARCHAR(255),
  code NVARCHAR(30) NOT NULL,
  name NVARCHAR(80) NOT NULL,
  criticality INTEGER DEFAULT 0,
  isFinal BOOLEAN DEFAULT FALSE,
  PRIMARY KEY(ID)
);

CREATE TABLE com_mycompany_complaints_Complaintcomments (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP_TEXT,
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP_TEXT,
  modifiedBy NVARCHAR(255),
  text NCLOB NOT NULL,
  authorName NVARCHAR(120) NOT NULL,
  isInternal BOOLEAN DEFAULT FALSE,
  complaint_ID NVARCHAR(36) NOT NULL,
  PRIMARY KEY(ID)
);

