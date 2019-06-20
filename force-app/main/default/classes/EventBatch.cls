/**
    Name        : EventBatch 
    Date        : 30 September, 2016
    Author      :
    Description : This Batch class update Last_Meeting_Date__c field of account Object according to most recent (non-future) event connected to that account
**/
global class EventBatch implements Database.Batchable<sObject>{
    String query,whatidField,activityField;
    global EventBatch(String queryEvent){
        query= queryEvent;     
    }
    global EventBatch(){}
    
    global Database.QueryLocator start(Database.BatchableContext Bc){
        if(String.ISBLANK(query)){
            query= 'Select id,whatId,ActivityDate from event where activitydate <= TODAY';
        }            
       return Database.getQueryLocator(query); 
    }
    
    global void execute(Database.BatchableContext Bc, List<Event> eventList){
        EventServices handler= new EventServices(); 
        handler.onAfterInsert(eventList);
    }  
    global void finish(Database.BatchableContext Bc){
    } 
}