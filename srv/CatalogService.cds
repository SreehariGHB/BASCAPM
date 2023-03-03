using {anubhav.db.master,anubhav.db.transaction  } from '../db/datamodel';


service CatalogService @(path:'/CatalogService'){

@Capabilities : {Insertable,Updatable:true,Deletable}
entity EmployeeSet as projection on master.employees;
entity AddressSet as projection on master.address;
entity ProductSet as projection on master.product;
// entity ProductTexts as projection on master.prodtext;
entity BpSet as projection on master.businesspartner; 

entity POs @(title: 'Purchase Order') as projection on transaction.purchaseorder{
    *,
     round(GROSS_AMOUNT,2) as GROSS_AMOUNT: Decimal(15,2),
     Items: redirected to Poitems
}actions{
  function largestOrder() returns array of POs;
  action boost();
};


entity Poitems @(title:'PO Items') as projection on transaction.poitems{
    *, PARENT_KEY: redirected to POs,
       PRODUCT_GUID: redirected to ProductSet       
}


}