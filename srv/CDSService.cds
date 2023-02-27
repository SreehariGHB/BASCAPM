using {anubhav.db.CDSViews  } from '../db/CDSViews';
using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';

service CDSService @(path: '/CDSService') {

    entity POWorklist as projection on CDSViews.POWorklist;
    entity ProductOrders as projection on CDSViews.ProductViewSub;
    entity ProductAggregation as projection on CDSViews.CProdcutValueView;
    

}
