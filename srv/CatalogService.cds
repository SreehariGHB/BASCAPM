using {anubhav.db.master,anubhav.db.transaction  } from '../db/datamodel';


service CatalogService @(path:'/CatalogService'){

entity EmployeeSet as projection on master.employees;
entity AddressSet as projection on master.address;
entity ProductSet as projection on master.product;
// entity ProductTexts as projection on master.prodtext;
entity BpSet as projection on master.businesspartner; 

entity POs @(title: '{i18n>PoHeader}')as projection on transaction.purchaseorder{
    *, Items: redirected to Poitems
}

entity Poitems @(title:'{i18n>PoItems}') as projection on transaction.poitems{
    *, PARENT_KEY: redirected to POs,
       PRODUCT_GUID: redirected to ProductSet       
}


}