trigger SalesOrderItemTrigger on Sales_Order_Item__c(after insert, after update) {
    SalesOrderItemTriggerHelper handler = new SalesOrderItemTriggerHelper();
    if(Trigger.isInsert && Trigger.isAfter){
        SalesOrderItemTriggerHelper.afterInsert(Trigger.new);
    }
    if(Trigger.isupdate && Trigger.isAfter){
         SalesOrderItemTriggerHelper.afterUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
    }
}