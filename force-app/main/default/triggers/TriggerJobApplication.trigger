trigger TriggerJobApplication on Job_Application__c(After Insert,after Update) {
     List<Job_Application__c> FilterjobApplicationList = new List<Job_Application__c>(); 
     if(Trigger.isInsert){
             JobApplicationTriggerHelper.sendEmail(Trigger.new);
         
     }
     if(Trigger.isUpdate){
         JobApplicationTriggerHelper.sendEmail(Trigger.old);
     
     }
       
}