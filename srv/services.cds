using {com.mycompany.complaints as db} from '../db/schema';

@path    : '/complaint'
@requires: 'authenticated-user'
service ComplaintsService {

    @odata.draft.enabled
    @(restrict: [
        {
            grant: [
                'READ',
                'CREATE',
                'UPDATE'
            ],
            to   : 'SupportAgent'
        },
        {
            grant: '*',
            to   : 'ComplaintManager'
        }
    ])
    entity Complaints        as projection on db.Complaints;

    @readonly
    @(restrict: [{
        grant: 'READ',
        to   : [
            'SupportAgent',
            'ComplaintManager'
        ]
    }])
    @cds.odata.valuelist
    entity Customers         as projection on db.Customers;

    @readonly
    @(restrict: [{
        grant: 'READ',
        to   : [
            'SupportAgent',
            'ComplaintManager'
        ]
    }])
    @cds.odata.valuelist
    entity Products          as projection on db.Products;

    @readonly
    @(restrict: [{
        grant: 'READ',
        to   : [
            'SupportAgent',
            'ComplaintManager'
        ]
    }])
    @cds.odata.valuelist

    entity Statuses          as projection on db.Statuses;

    @(restrict: [
        {
            grant: [
                'READ',
                'CREATE',
                'UPDATE'
            ],
            to   : 'SupportAgent'
        },
        {
            grant: '*',
            to   : 'ComplaintManager'
        }
    ])
    entity ComplaintComments as projection on db.ComplaintComments;
}
