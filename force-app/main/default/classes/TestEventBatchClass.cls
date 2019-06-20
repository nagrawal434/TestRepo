/**
    Name        : TestEventBatchClass 
    Date        : 30 September, 2016
    Author      :
    Description : This test class produce the code coverage for EventBatchClass batch Class.
**/

@isTest
private class TestEventBatchClass {

    static testmethod void TestEventBatchClass_test() {
        // The query used by the batch job.
        String status= 'Completed';
        
        Account accRecord= new Account(name= 'test');
        insert accRecord;
        
        // Insert Event of accRecord 
        Event eventRecord= new Event(subject= 'NewEvent',ActivityDate= system.today()-3,durationInMinutes=2,
                                    ActivityDateTime= System.now()-3,
                                    WhatId= accRecord.id);
        insert eventRecord;
        
        System.assertEquals([Select id,Last_Meeting_Date__c from account where id= :accRecord.id].Last_Meeting_Date__c,eventRecord.activitydate);
        
        // Second record is insert to test Date
        Event eventRecordSecond= new Event(subject= 'NewEvent',ActivityDate= system.today()-2,durationInMinutes=2,
                                    ActivityDateTime= System.now()-2,
                                    WhatId= accRecord.id);
        insert eventRecordSecond;
        
        // Check Last_Meeting_Date__c field is updated according to Second because second event Activity date is greater than the activitydate of first event 
        System.Equals([Select id,Last_Meeting_Date__c from account where id= :accRecord.id].Last_Meeting_Date__c,eventRecordSecond.activitydate);
        
        eventRecord.ActivityDate = System.today()-1;
        eventRecord.ActivityDateTime= System.now()-1;
        eventRecord.durationInMinutes=2;
        update eventRecord;
        
        // When Event id updated Check for Last_Meeting_Date__c of Account object Because new updated activitydate of first Event is than its old Activitydate 
        System.Equals([Select id,Last_Meeting_Date__c from account where id= :accRecord.id].Last_Meeting_Date__c,eventRecord.activitydate);
        Test.startTest();
        EventBatch c = new EventBatch();
        
        EventBatch cnew = new EventBatch('select id,activitydate,whatid from event where activitydate <= TODAY');
        Database.executeBatch(c);
        Database.executeBatch(cnew);
        Test.stopTest();
    }
}