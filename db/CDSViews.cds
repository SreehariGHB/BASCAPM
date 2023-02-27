namespace anubhav.db;

using { anubhav.db.master, anubhav.db.transaction } from './datamodel';

context CDSViews {

    define view![POWorklist] as 

    select from transaction.purchaseorder{
        key PO_ID as ![PurchaseOrderID],
            PARTNER_GUID.BP_ID as ![PartnerGuid],
            GROSS_AMOUNT as ![POGrossAmount],
            NET_AMOUNT as ![PONetAmount],
            TAX_AMOUNT as ![POTAX_AMOUNT],
            CURRENCY_CODE as ![POCurrencyCode],
            LIFECYCLE_STATUS as ![LifeCycleStatus],
            OVERALL_STATUS as ![OverallStatus],
            key Items.PO_ITEM_POS as ![POItemPosition],
                Items.PRODUCT_GUID.PRODUCT_ID as ![ProductID],
                Items.PRODUCT_GUID.DESCRIPTION as ![ProductName],
                PARTNER_GUID.ADDRESS_GUID.CITY as ![CITY],
                PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
                Items.GROSS_AMOUNT as  ![ItemGrossAmount],
                Items.NET_AMOUNT as ![ItemNetAmount],
                Items.TAX_AMOUNT as ![ItemTaxAmount],
                Items.CURRENCY_CODE as ![ItemCurrencyCode]
    };

    define view ProductValueHelp as 
    select from master.product{
        @EndUserText.label:[{
           language: 'EN',
           text: 'Product ID' 
        },
        { language: 'DE',
          text: 'Prodekt ID'
        } ]
        PRODUCT_ID as ![ProductID],
        @EndUserText.label:[{
            language: 'EN',
            text: 'Product Description'
            },
            {
            language: 'DE',
            text: 'Prodekt Description'
            }]
            DESCRIPTION as ![Description]
    };
    define view![ItemView] as                  //Case Sensitive View
    select from transaction.poitems{
      PARENT_KEY.PARTNER_GUID.NODE_KEY as ![Partner],
      PRODUCT_GUID.NODE_KEY as ![ProductID],
      CURRENCY_CODE as ![CurrencyCode],
      GROSS_AMOUNT as ![GrossAmount],
      NET_AMOUNT as ![NetAmount],
      TAX_AMOUNT as ![TaxAmount],
      PARENT_KEY.OVERALL_STATUS as ![POStatus]  
    };

    define view ProductViewSub as 
      select from master.product as prod{
        PRODUCT_ID as ![ProductID],
        texts.DESCRIPTION as ![Description],
        (
          select from transaction.poitems as a{
            SUM(a.GROSS_AMOUNT) as SUM
          } where a.PRODUCT_GUID.NODE_KEY = prod.NODE_KEY
        ) as PO_SUM:Decimal(15,2)
      };

 // MIXIN Functionality
    define view ProductView as select from master.product
    mixin{
        PO_ORDERS: Association[*] to ItemView on
                   PO_ORDERS.ProductID = $projection.ProductId
    } 
    into{
            NODE_KEY as![ProductId],
            DESCRIPTION,
            CATEGORY as![Category],
            PRICE as![Price],
            TYPE_CODE as![TypeCode],
            SUPPLIER_GUID.BP_ID as![BPId],
            SUPPLIER_GUID.COMPANY_NAME as![CompanyName],
            SUPPLIER_GUID.ADDRESS_GUID.CITY as![City],
            SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as![Country],
            //Exposed Association, which means when someone read the view
            //the data for orders wont be read by default
            //until unless someone consume the association
            PO_ORDERS 
    };

    // Consumption View

    define view CProdcutValueView as 
    select from ProductView{
        ProductId,
        Country,
        PO_ORDERS.CurrencyCode as ![CurrencyCode],
        SUM(PO_ORDERS.GrossAmount) as ![POGrossAmount] : Decimal(15,2)
    } group by ProductId,Country,PO_ORDERS.CurrencyCode
    
}
