namespace anubhav.db;

using
{
    cuid,
    managed,
    temporal,
    Currency
}
from '@sap/cds/common';

using { anubhav.common } from './common';

type guid : String(32);

context master
{
    entity businesspartner
    {
        key NODE_KEY : guid
            @title : '{i18n>bp_key}';
        BP_ROLE : String(2)
            @title : '{i18n>bp_role}';
        EMAIL_ADDRESS : String(64)
            @title : '{i18n>email_addr}';
        PHONE_NUMBER : String(14);
        FAX_NUMBER : String(14);
        WEB_ADDRESS : String(64);
        ADDRESS_GUID : Association to one address;
        BP_ID : String(16)
            @title : '{i18n>bp_id}';
        COMPANY_NAME : String(64)
            @title : '{i18n>company_name}';
    }

    entity address
    {
        key NODE_KEY : guid;
        CITY : String(64);
        POSTAL_CODE : String(14);
        STREET : String(64);
        BUILDING : String(64);
        COUNTRY : String(2);
        ADDRESS_TYPE : String(2);
        VAL_START_DATE : Date;
        VAL_END_DATE : Date;
        LATITUDE : Decimal;
        LONGITUDE : Decimal;
        businesspartner : Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;
    }

    entity product
    {
        key NODE_KEY : guid;
        PRODUCT_ID : String(28);
        TYPE_CODE : String(2);
        CATEGORY : String(32);
        DESCRIPTION : localized String(255);
        SUPPLIER_GUID : Association to one businesspartner;
        TAX_TARIF_CODE : Integer;
        MEASURE_UNIT : String(2);
        WEIGHT_MEASURE : Decimal(5,2);
        WEIGHT_UNIT : String(2);
        CURRENCY_CODE : String(4);
        PRICE : Decimal(15,2);
        WIDTH : Decimal(5,2);
        DEPTH : Decimal(5,2);
        HEIGHT : Decimal(5,2);
        DIM_UNIT : String(2);
    }

    entity employees : cuid
    {
        nameFirst : String(40);
        nameMiddle : String(40);
        nameLast : String(40);
        nameInitials : String(40);
        sex : common.Gender;
        language : String(1);
        phoneNumber : common.PhoneNumber;
        email : common.Email;
        loginName : String(12);
        currency : Currency;
        salaryAmount : common.AmountT;
        accountNumber : String(16);
        bankId : String(20);
        bankName : String(64);
    }
}

    //  key ID : UUID @odata.Type:'Edm.String';
context transaction
{
            entity purchaseorder : common.Amount,cuid
    {
           PO_ID : String(24);
        PARTNER_GUID : Association to one master.businesspartner;
        LIFECYCLE_STATUS : String(1);
        OVERALL_STATUS : String(1);
        Items : Association to many poitems on Items.PARENT_KEY = $self;
        NOTE: String(256);
    }
// key ID : UUID @odata.Type:'Edm.String';
    entity poitems : common.Amount,cuid
    {
        PARENT_KEY : Association to one purchaseorder;
        PO_ITEM_POS : Integer;
        PRODUCT_GUID : Association to one master.product;
    }
}
