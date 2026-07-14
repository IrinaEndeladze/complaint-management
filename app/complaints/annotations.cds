using ComplaintsService as service from '../../srv/services';

annotate service.Complaints with @(
    UI.HeaderInfo                              : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Complaint',
        TypeNamePlural: 'Complaints',
        Title         : {
            $Type: 'UI.DataField',
            Value: subject
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: status.name
        }
    },

    UI.SelectionFields                         : [
        status,
        priority,
        customer,
        product,
        reportedAt
    ],

    UI.LineItem                                : [
        {
            $Type         : 'UI.DataField',
            Value         : subject,
            Label         : 'Subject',
            @UI.Importance: #High
        },
        {
            $Type         : 'UI.DataField',
            Value         : customer.firstName,
            Label         : 'Customer',
            @UI.Importance: #High
        },
        {
            $Type         : 'UI.DataField',
            Value         : product.name,
            Label         : 'Product',
            @UI.Importance: #High
        },
        {
            $Type         : 'UI.DataField',
            Value         : status.name,
            Label         : 'Status',
            @UI.Importance: #High
        },
        {
            $Type         : 'UI.DataField',
            Value         : priority,
            Label         : 'Priority',
            @UI.Importance: #High
        },
        {
            $Type         : 'UI.DataField',
            Value         : reportedAt,
            Label         : 'Reported At',
            @UI.Importance: #High
        }
    ],

    UI.Facets                                  : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneralInformation',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneralInformation'
    }],

    UI.FieldGroup #GeneralInformation          : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: subject,
                Label: 'Subject'
            },
            {
                $Type: 'UI.DataField',
                Value: description,
                Label: 'Description'
            },
            {
                $Type: 'UI.DataField',
                Value: customer_ID,
                Label: 'Customer'
            },
            {
                $Type: 'UI.DataField',
                Value: product_ID,
                Label: 'Product'
            },
            {
                $Type: 'UI.DataField',
                Value: status_ID,
                Label: 'Status'
            },
            {
                $Type: 'UI.DataField',
                Value: priority,
                Label: 'Priority'
            },
            {
                $Type: 'UI.DataField',
                Value: reportedAt,
                Label: 'Reported At'
            },
            {
                $Type: 'UI.DataField',
                Value: resolvedAt,
                Label: 'Resolved At'
            },
            {
                $Type: 'UI.DataField',
                Value: resolutionSummary,
                Label: 'Resolution Summary'
            }
        ]
    },

    UI.SelectionPresentationVariant #tableView : {
        $Type              : 'UI.SelectionPresentationVariantType',
        Text               : 'Table View',

        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            SelectOptions: []
        },

        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem']
        }
    },

    UI.SelectionPresentationVariant #tableView1: {
        $Type              : 'UI.SelectionPresentationVariantType',
        Text               : 'Table View 1',

        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            SelectOptions: []
        },

        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem']
        }
    }
);

annotate service.Complaints with {
    subject
             @Common.Label: 'Subject';

    description
             @Common.Label: 'Description';

    priority
             @Common.Label: 'Priority';

    reportedAt
             @Common.Label: 'Reported At';

    resolvedAt
             @Common.Label: 'Resolved At';

    resolutionSummary
             @Common.Label: 'Resolution Summary';
    customer @(

        Common.Label                   : 'Customer',

        Common.Text                    : customer.firstName,

        Common.Text.@UI.TextArrangement: #TextOnly
    );

    product  @(

        Common.Label                   : 'Product',

        Common.Text                    : product.name,

        Common.Text.@UI.TextArrangement: #TextOnly

    );

    status   @(

        Common.Label                   : 'Status',

        Common.Text                    : status.name,

        Common.Text.@UI.TextArrangement: #TextOnly

    );


};
