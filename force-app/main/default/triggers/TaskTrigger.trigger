/**
    Name        : TaskTrigger
    Date        : 29 Sep, 2016
    Author      :
    Description : This Trigger for Task Object to update Last_Call_Date__c Field of Account Field
**/
trigger TaskTrigger on Task (after insert,after update){    
    TaskServices handler= new TaskServices();
    
    // After insert trigger on insert record for Account object
    if(Trigger.isAfter && Trigger.isInsert){
        handler.onAfterInsert(Trigger.new);    
    }
    
    // After update trigger on update record for Account 
    if(Trigger.isAfter && Trigger.isUpdate){
        handler.onAfterUpdate(Trigger.new,Trigger.oldMap);
    }          
}