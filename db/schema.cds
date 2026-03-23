namespace sap.cap.productshop;
entity Product {
    key ID       : Integer;
        name     : String;
        stock    : Integer;
        price    : Integer;
        category : Integer;
}

entity Supplier {
    key ID      : UUID;
        name    : String(100);
        city    : String(100);
        phone   : Integer;
}
