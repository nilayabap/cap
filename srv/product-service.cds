using { sap.cap.productshop as my } from '../db/schema';

service productshop
{
//    @odata.draft.enabled
    entity Product as
        projection on my.Product
        actions
        {
            action orderProduct
            (
//                @title : 'Order Product'
//                name : String,
                @title : 'Stock Quantity'
                stock : Integer
            );

            action createPO
            (
                name : String
            );
        };

    entity Supplier as
        projection on my.Supplier;

    function MyFunction
    (
        name : String
    )
    returns String;

    action MyAction
    (
        name : String
    )
    returns String;
}


//annotate productshop with @(requires : 'productmanager');
