using ibmcapapp.srv.CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(
    UI.SelectionFields      : [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],
    UI.LineItem             : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        {
            // Label: '{i18n>country}',
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY
        },
        {
            Label : 'Boost',
            $Type : 'UI.DataFieldForAction',
            Action: 'ibmcapapp.srv.CatalogService.boost',
        // Inline: true //removed to take the action on table header o/w will show in tab coln.
        },
        // {
        //     Label : 'Largest Order',
        //     $Type : 'UI.DataFieldForAction',
        //     Action: 'ibmcapapp.srv.CatalogService.largestOrder',
        // },
        {
            Label: '{i18n>GrossAmount}',
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type                    : 'UI.DataField',
            Criticality              : Criticality,
            CriticalityRepresentation: #WithIcon,
            Value                    : OverallStatus
        }
    ],
    UI.HeaderInfo           : {
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {Value: PO_ID},
        Description   : {Value: PARTNER_GUID.COMPANY_NAME},
        ImageUrl      : 'https://sapui5.hana.ondemand.com/resources/sap/ui/documentation/sdk/images/ui5-logo-light.svg',
    },
    UI.Facets               : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'More Details',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Info',
                    Target: '@UI.Identification',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing',
                    Target: '@UI.FieldGroup#Superman',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status',
                    Target: '@UI.FieldGroup#Spiderman',
                }

            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'Items/@UI.LineItem',
            Label : 'PO Items'
        }
    ],
    UI.Identification       : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID_NODE_KEY
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        // {
        //     $Type: 'UI.DataField',// changed to ID for HANA deployment
        //     Value: NODE_KEY
        // }
        {
            $Type: 'UI.DataField',
            Value: ID
        }
    ],
    UI.FieldGroup #Spiderman: {Data: [
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        },
        {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS
        },
        {
            $Type: 'UI.DataField',
            Value: LIFECYCLE_STATUS
        }

    ]},
    UI.FieldGroup #Superman : {Data: [
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT
        }

    ]}
);

annotate service.POItems with @(
    UI.LineItem            : [
        {
            $Type                : 'UI.DataField',
            Value                : PO_ITEM_POS,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {width: '8rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : PRODUCT_GUID_NODE_KEY,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {width: '30rem'},

        },
        {
            $Type                : 'UI.DataField',
            Value                : GROSS_AMOUNT,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {width: '15rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : CURRENCY_code,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {width: '15rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : NET_AMOUNT,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {width: '15rem'}
        },
        {
            $Type                : 'UI.DataField',
            Value                : TAX_AMOUNT,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {width: '10rem'}
        }
    ],
    UI.HeaderInfo          : {
        TypeName      : 'Purchase Order Item',
        TypeNamePlural: 'Purchase Order Items',
        Title         : {Value: PO_ITEM_POS},
        Description   : {Value: PRODUCT_GUID.DESCRIPTION},
        ImageUrl      : 'https://sapui5.hana.ondemand.com/resources/sap/ui/documentation/sdk/images/ui5-logo-light.svg',
    },
    UI.Facets              : [{
        $Type : 'UI.CollectionFacet',
        Label : 'More Details',
        Facets: [
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'More Info',
                Target: '@UI.Identification',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Pricing',
                Target: '@UI.FieldGroup#ItemData',
            }
        ],
    }],
    UI.Identification      : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY
        }
    ],
    UI.FieldGroup #ItemData: {Data: [
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        }

    ]}
);

annotate service.POs with {
    PARTNER_GUID @(
        Common.Text     : PARTNER_GUID.COMPANY_NAME,
        ValueList.entity: service.BusinessPartner
    )
};

annotate service.POItems with {
    PRODUCT_GUID @(
        Common.Text     : PRODUCT_GUID.DESCRIPTION,
        ValueList.entity: service.ProductSet
    )
};


@cds.odata.valuelist
annotate service.BusinessPartner with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: COMPANY_NAME

}]);

@cds.odata.valuelist
annotate service.ProductSet with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: DESCRIPTION
}]);

//comment to check CI/CD