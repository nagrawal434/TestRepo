/**
    Name        : TestEventTrigger
    Date        : 30 September, 2016
    Author      :
    Description : This test class produce the code coverage for TaskTrigger trigger and Check Last_Meeting_Date__c field of account Object 
                  //will update according to most recent Event (non-future) .
**/
@isTest
Private Class TestEventTrigger{
    static testMethod void EventTrigger_Test1(){
        
        //Insert Account
        Account accRecord1= new Account(name= 'test');
        insert accRecord1;
        
        // Insert Event of accRecord 
        Event eventRecord= new Event(subject= 'NewEvent',ActivityDate= System.today()-2,
                                    durationInMinutes= 2,ActivityDateTime= System.now()-2,
                                    WhatId= accRecord1.id);
        insert eventRecord;
        
        // Assert to check Last_Meeting_Date field of account is Equals to ActivityDate of eventRecord of account 
        System.assertEquals([Select id,Last_Meeting_Date__c from Account Where id = :accRecord1.id].Last_Meeting_Date__c,eventRecord.ActivityDate);
        // insert second activity if its activitydate is Less than to currentDate and Greater than to any FirstEvent than Last_Meeting_Date__c will be its ActivityDate
        Event eventRecordSecond= new Event(subject= 'NewEvent', ActivityDate= system.today()-3,durationInMinutes=2,
                                           ActivityDateTime= System.now()-3,      
                                           WhatId= accRecord1.id);
        insert eventRecordSecond;
        
        // assert to check Last_Meeting_Date__c will be equals to activitydate of eventRecord because eventRecordSecond.activitydate < eventRecord.activityDate > system.now   
        System.assertEquals([Select id,Last_Meeting_Date__c from Account Where id = :accRecord1.id].Last_Meeting_Date__c,eventRecord.ActivityDate);
        // Update activityDate of Event eventRecord 
        eventRecord.ActivityDate = System.today()-1;
        eventRecord.ActivityDateTime= System.now()-1;
        eventRecord.durationInMinutes=2;
        update eventRecord;
        
        // assert to check afterupdation of Activitydate of Event 
        System.assertEquals([Select id,Last_Meeting_Date__c from Account Where id = :accRecord1.id].Last_Meeting_Date__c,eventRecord.ActivityDate);   
    }
}