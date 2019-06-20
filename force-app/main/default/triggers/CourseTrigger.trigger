trigger CourseTrigger on Course__c(after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        courseHelper.onAfterUpdate(Trigger.new , Trigger.oldMap);       
    }
}