trigger customerTrigger on Customer__c(after insert){
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        customerHelper.onInsertUpdate(Trigger.new );
    }

}