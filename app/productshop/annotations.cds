using productshop as service from '../../srv/product-service';
using from '../../db/schema';

annotate service.Product with @(

    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'ID',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'stock',
                Value : stock,
            },
            {
                $Type : 'UI.DataField',
                Label : 'price',
                Value : price,
            },
            {
                $Type : 'UI.DataField',
                Label : 'category',
                Value : category,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Suppliar Information',
            ID : 'SuppliarInformation',
            Target : '@UI.FieldGroup#SuppliarInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Conversion Details',
            ID : 'ConversionDetails',
            Target : 'conversation/@UI.LineItem#ConversionDetails',
        },
    ],
    UI.LineItem : [
        { Value : ID, Label : 'ID' },
        { Value : name, Label : 'Name' },
        { Value : stock, Label : 'Stock' },
        { Value : price, Label : 'Price' },
        { Value : category, Label : 'Category', },
        {
            $Type : 'UI.DataField',
            Value : criticality,
            Criticality : criticality,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'productshop.orderProduct',
            Label : '{i18n>ProductStock}',
            Inline : true,
            Criticality : #Positive,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'productshop.createPO',
            Label : 'Create PO',
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#emission',
            Label : 'Rating',
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#Progress',
            Label : 'Progress',
            ProgressIndicatorType : 'Compact',
        },
    ],
    UI.SelectionFields : [
        category,
        criticality,
         ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : supplier.name,
        },
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'productshop.orderProduct',
            Label : 'Order Product',
            Criticality : #Positive,
        },
    ],
    UI.FieldGroup #SuppliarInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : supplier.name,
                Label : 'name',
            },
            {
                $Type : 'UI.DataField',
                Value : supplier.city,
                Label : 'city',
            },
            {
                $Type : 'UI.DataField',
                Value : supplier.phone,
                Label : 'phone',
            },
        ],
    },
    UI.DataPoint #emission : {
        Value : emission,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.DataPoint #stock : {
        Value : stock,
        Visualization : #Progress,
        TargetValue : 100,
    },
    UI.DataPoint #Progress : {
        Value : Progress,
        Visualization : #Progress,
        TargetValue : 100,
        Criticality : criticality,
        ProgressIndicatorType : 'Compact',
    },
);

annotate service.Product with {
    rating @Common.Label : 'rating'
};

annotate service.Product.conversation with @(
    UI.LineItem #ConversionDetails : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : message,
            Label : 'message',
        },
        {
            $Type : 'UI.DataField',
            Value : processor,
            Label : 'processor',
        },
        {
            $Type : 'UI.DataField',
            Value : timestamp,
            Label : 'timestamp',
        },
    ]
);

annotate service.Supplier with {
    name @Common.FieldControl : #ReadOnly
};

annotate service.Supplier with {
    city @Common.FieldControl : #ReadOnly
};

annotate service.Supplier with {
    phone @Common.FieldControl : #ReadOnly
};

annotate service.Product with {
    category @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Product',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : category,
                    ValueListProperty : 'category',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'emission',
                },
            ],
            Label : 'Category',
        },
        Common.ValueListWithFixedValues : false,
)};

