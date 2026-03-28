namespace sap.cap.productshop;

using {managed} from '@sap/cds/common';

aspect carbonemission {
    emission : Integer;
    rating   : String;
}

entity Product : managed, carbonemission {
    key ID           : Integer;
        name         : String;
        stock        : Integer;
        price        : Integer;
        category     : Integer;
        criticality  : Integer;
        Progress     : Integer;
        supplier     : Association to one Supplier;
        conversation : Composition of many {
                           key ID        : Integer;
                               timestamp : String;
                               processor : String;
                               message   : String;
                       }
}

entity Supplier {
    key ID       : UUID;
        name     : String(100);
        city     : String(100);
        phone    : Integer;
        products : Association to many Product
                       on products.supplier = $self;
}
