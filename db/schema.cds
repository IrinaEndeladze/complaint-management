namespace com.mycompany.complaints;


using {
    cuid,
    managed
} from '@sap/cds/common';


type ComplaintPriority : String(10) enum {
    LOW;
    MEDIUM;
    HIGH;
    CRITICAL;
}

entity Customers : cuid, managed {
    firstName  : String(80) not null;
    lastName   : String(80) not null;
    email      : String(150) not null;
    phone      : String(30);
    complaints : Association to many Complaints
                     on complaints.customer = $self;
}

entity Products : cuid, managed {
    name         : String(120) not null;
    category     : String(80);
    serialNumber : String(100);
    isActive     : Boolean default true;

    complaints   : Association to many Complaints
                       on complaints.product = $self;
}

entity Statuses : cuid, managed {
    code        : String(30) not null;
    name        : String(80) not null;
    criticality : Integer default 0;
    isFinal     : Boolean default false;

    complaints  : Association to many Complaints
                      on complaints.status = $self;
}

entity Complaints : cuid, managed {
    @mandatory
    subject           : String(150) not null;

    @mandatory
    description       : LargeString not null;
    priority          : ComplaintPriority default 'MEDIUM';
    reportedAt        : Timestamp;
    resolvedAt        : Timestamp;
    resolutionSummary : LargeString;

    customer          : Association to Customers not null;
    product           : Association to Products;
    status            : Association to Statuses not null;
    comments          : Composition of many ComplaintComments
                            on comments.complaint = $self;

}

entity ComplaintComments : cuid, managed {
    text       : LargeString not null;
    authorName : String(120) not null;
    isInternal : Boolean default false;

    complaint  : Association to Complaints not null;
}
