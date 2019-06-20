/**
    Name        : TestTaskTrigger
    Date        : 30 September, 2016
    Author      :
    Description : This test class produce the code coverage for TaskTrigger trigger.
**/
@isTest
Private Class TestTaasktTrigger{
    
    static testMethod void TaskTrigger_Test1(){
        
        // insert account
        Account accRecord= new Account(name= 'newTest');
        insert accRecord;
        
        //insert task of accRecord Account
        Task tsk= new Task(subject='CallDemo',ActivityDate = System.today() + 2,
                        WhatId= accRecord.id,status= 'Completed');
        insert tsk;
        
        system.assertEquals([SELECT id,Last_Call_Date__c from Account where id= :accRecord.id].Last_Call_Date__c,tsk.ActivityDate);
        
        // Insert Second record of Task of Account
        Task tskSecond= new Task(subject='CallDemo',ActivityDate = System.today()+ 3,
                        WhatId= accRecord.id,status= 'Completed');
        insert tskSecond;
        
        // Assert to check most recent phone Call task 
        system.assertEquals([SELECT id,Last_Call_Date__c from Account where id= :accRecord.id].Last_Call_Date__c,tskSecond.ActivityDate);  
        update tsk;       
    }
}