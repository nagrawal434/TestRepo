/**
    Name        : TaskBatch
    Date        : 30 September, 2016
    Author      :
    Description : This Batch class update Last_Call_Date__c field of account Object according to most recent phone-call task
**/
global class TaskBatch implements Database.Batchable<sObject>{
   
    String query;
    global TaskBatch(String queryTask){
        query = queryTask; 
    }
    global TaskBatch(){
    
    }
    global Database.QueryLocator start(Database.BatchableContext Bc){
       
       if(String.isBLANK(query)){
           query= 'Select id,whatId from Task Where Status = \''+'Completed'+'\' AND Subject Like \'%'+'Call'+'%\' ';    
       }
       return Database.getQueryLocator(query); 
    }
    
    global void execute(Database.BatchableContext Bc, List<Task> taskList){
        TaskServices handler= new TaskServices(); 
        handler.onAfterInsert(taskList);
    }  
    global void finish(Database.BatchableContext Bc){
    
    } 
}