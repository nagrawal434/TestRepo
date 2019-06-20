trigger OppTriggerCloseDate on Opportunity (after insert,after update) {
    if(Trigger.isAfter && Trigger.isInsert){
        OpportunityHelper.onInsert(Trigger.new);
    } 
    if(Trigger.isAfter && Trigger.isUpdate){
        OpportunityHelper.onUpdate(Trigger.new,Trigger.oldMap);    
    }
}