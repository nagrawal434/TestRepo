/**
    Name        : EventTrigger
    Date        : 29 Sep, 2016
    Author      :
    Description : This Trigger for Event Object to update Last_Meeting_Date__c Field of Account Field
**/

trigger EventTrigger on Event (after insert,after update){    
    EventServices handler= new EventServices();
    
    // After insert trigger on insert record for Account object  
    if(Trigger.isAfter && Trigger.isInsert){
        handler.onAfterInsert(Trigger.new);    
    }
    // After update trigger on update record for Account 
    if(Trigger.isAfter && Trigger.isupdate){
        handler.onAfterUpdate(Trigger.new,Trigger.oldMap);  
    }        
}