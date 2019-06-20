trigger AccountAddressTrigger on Account (before insert,before update){
    if(Trigger.isInsert){
        for(Account a : Trigger.New){
            if(a.Match_Billing_Address__c == true && a.BillingPostalCode != null){
                System.debug('###' +a.shippingPostalCode);
                a.ShippingPostalCode = a.BillingPostalCode;
                System.debug('@@@@' +a.shippingPostalCode);
            }    
        System.debug('$$$$' +a.shippingPostalCode);
        } 
    }
    if(Trigger.isUpdate){
        for(Account a : Trigger.New){
            if(a.Match_Billing_Address__c == true && a.BillingPostalCode != null){
                a.ShippingPostalCode = a.BillingPostalCode;
            }
        
        }
    }

}