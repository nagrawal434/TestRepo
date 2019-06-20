trigger HireProcessTrigger on Hire_Form__c(Before insert,Before update) {
     Hire_Form__c hireProcessList = new Hire_Form__c();
     if(trigger.isBefore || trigger.isAfter){
         HireProcessTriggerHelper.createNewContactCase(Trigger.new);    
     }
     if(trigger.isupdate){
         HireProcessTriggerHelper.UpdateMethod(Trigger.new);    
     }
     
}