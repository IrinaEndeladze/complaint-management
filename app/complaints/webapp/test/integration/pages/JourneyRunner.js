sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/mycompany/complaints/complaints/test/integration/pages/ComplaintsList.gen",
	"com/mycompany/complaints/complaints/test/integration/pages/ComplaintsObjectPage.gen",
	"com/mycompany/complaints/complaints/test/integration/pages/ComplaintCommentsObjectPage.gen"
], function (JourneyRunner, ComplaintsListGenerated, ComplaintsObjectPageGenerated, ComplaintCommentsObjectPageGenerated) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/mycompany/complaints/complaints') + '/test/flp.html#app-preview',
        pages: {
			onTheComplaintsListGenerated: ComplaintsListGenerated,
			onTheComplaintsObjectPageGenerated: ComplaintsObjectPageGenerated,
			onTheComplaintCommentsObjectPageGenerated: ComplaintCommentsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

