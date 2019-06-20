public class SalesOrderItemTriggerHelper{
    public static void afterInsert(List<sales_Order_item__c> NewSalesItemList){
        System.debug('@@@@@' +NewSalesItemList);
        updatePrimaryCountry(NewSalesItemList);                         
    }
    public Static void afterUpdate(List<sales_Order_item__c> oldSalesItemRecord,List<sales_order_item__c> updateSalesItemRecord,Map<Id,sales_Order_item__c> oldMap,Map<Id,sales_Order_item__c> newMap){
        System.debug('****' +oldSalesItemRecord);
        updatePrimaryCountry(updateSalesItemRecord);    
    }
    private Static void updatePrimaryCountry(List<sales_Order_item__c> record){
        Map<Id,String> salesOrderCountryMap = new Map<Id,String>();
        for(Sales_Order_Item__c soi : record){
            if(soi.Primary_Country__c)
                 salesOrderCountryMap.put(soi.SaleOrder__c,soi.Purchased_Country__c);
         } 
        List<Sales_Order__c> orders = [select id,Primary_Country__c from Sales_Order__c where id IN : salesOrderCountryMap.keyset()];
        System.debug('$$$$$' +orders);
        for (Sales_Order__c so : orders)
            so.Primary_Country__c = salesOrderCountryMap.get(so.id);
        // commit the records 
        update orders;   
    
    }
}