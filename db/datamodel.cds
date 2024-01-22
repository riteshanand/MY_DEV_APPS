namespace anubhav.db;

using {
    cuid,
    managed,
    temporal,
    Currency
} from '@sap/cds/common';
using {anubhav.common} from './commons';

context master {

    entity businesspartner {
        key NODE_KEY      : common.Guid @title: '{i18n>PartnerKey}';
            BP_ROLE       : String(2);
            EMAIL_ADDRESS : String(105);
            PHONE_NUMBER  : String(32);
            FAX_NUMBER    : String(32);
            WEB_ADDRESS   : String(44);
            ADDRESS_GUID  : Association to address;
            BP_ID         : String(32);
            COMPANY_NAME  : String(250) @title: '{i18n>CompName}';
    }

    entity address {
        key NODE_KEY        : common.Guid @title: '{i18n>addressKey}';
            CITY            : String(44);
            POSTAL_CODE     : String(8);
            STREET          : String(44);
            BUILDING        : String(128);
            COUNTRY         : String(10)  @title: '{i18n>country}';
            ADDRESS_TYPE    : String(44);
            VAL_START_DATE  : Date;
            VAL_END_DATE    : Date;
            LATITUDE        : Decimal;
            LONGITUDE       : Decimal;
            businesspartner : Association to one businesspartner
                                  on businesspartner.ADDRESS_GUID = $self;
    }

    entity product {
        key NODE_KEY       : common.Guid           @title: '{i18n>ProductKey}';
            PRODUCT_ID     : String(28)            @title: '{i18n>ProductId}';
            TYPE_CODE      : String(2);
            CATEGORY       : String(32)            @title: '{i18n>ProductCategory}';
            DESCRIPTION    : localized String(255) @title: '{i18n>ProductDescription}';
            SUPPLIER_GUID  : Association to master.businesspartner;
            TAX_TARIF_CODE : Integer;
            MEASURE_UNIT   : String(2);
            WEIGHT_MEASURE : Decimal(5, 2);
            WEIGHT_UNIT    : String(2);
            CURRENCY_CODE  : String(4);
            PRICE          : Decimal(15, 2)        @title: '{i18n>Price}';
            WIDTH          : Decimal(5, 2);
            DEPTH          : Decimal(5, 2);
            HEIGHT         : Decimal(5, 2);
            DIM_UNIT       : String(2);
    }

    entity employees : cuid {
        nameFirst     : String(40);
        nameMiddle    : String(40);
        nameLast      : String(40);
        nameInitials  : String(40);
        sex           : common.Gender;
        language      : String(1);
        phoneNumber   : common.PhoneNumber;
        email         : common.Email;
        loginName     : String(12);
        Currency      : Currency;
        salaryAmount  : common.AmountT;
        accountNumber : String(16);
        bankId        : String(40);
        bankName      : String(64);
    }
}

context transaction {
    entity purchaseorder : common.Amount {
        key NODE_KEY         : common.Guid @title: '{i18n>POKey}';
            PO_ID            : String(40)  @title: '{i18n>POId}';
            PARTNER_GUID     : Association to master.businesspartner;
            LIFECYCLE_STATUS : String(1);
            OVERALL_STATUS   : String(1)   @title: '{i18n>OverallStatus}';
            // Items            : Association to many poitems
            //                        on Items.PARENT_KEY = $self;
            Items            : Composition of  many poitems     // for draft enable functionality/CRUD
                                   on Items.PARENT_KEY = $self;
    }

    entity poitems : common.Amount {
        key NODE_KEY     : common.Guid @title: '{i18n>POItemKey}';
            PARENT_KEY   : Association to purchaseorder;
            PO_ITEM_POS  : Integer     @title: '{i18n>ItemPOS}';
            PRODUCT_GUID : Association to master.product;
    }
}
