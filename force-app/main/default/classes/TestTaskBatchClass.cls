@isTest
private class TestTaskBatchClass {

    static testmethod void TestTaskBatchClass_test() {
        // The query used by the batch job.
        String status= 'Completed';
        
       // Insert Account
       Account acc= new Account(name= 'test');
       insert acc;
       
       // Insert phone-call Task for acc account
       Task tsk= new Task(subject= 'NewCalltest',Status='Completed',activitydate=System.today()+ 6,
                           WhatId= acc.id);
       insert tsk;
       
       System.assertEquals([SELECT id,Last_Call_date__c from Account Where Id= :acc.id].last_call_date__c,tsk.activitydate);
       // Second phone-call task for acc account
       Task tskSec= new Task(subject= 'NewCalltestSec',Status='Completed',ActivityDate= system.today() + 7,
                           WhatId= acc.id);
       insert tskSec;
       
       // update last_call_date__c field of account object acc to sec Phone-call task beause its activitydate is greater than first Phone-call task and Status is Completed  
       System.assertEquals([SELECT id,Last_Call_date__c from Account Where Id= :acc.id].last_call_date__c,tskSec.activitydate);
       
       update tsk;
       
       Test.startTest();
       TaskBatch c = new TaskBatch();
       TaskBatch cNew = new TaskBatch('Select id,whatId from Task Where Status = \''+status+'\' AND Subject Like \'%'+'Call'+'%\'');
       Database.executeBatch(c);
       Database.executeBatch(cNew);
       Test.stopTest();
    }
}