/**
    Name        : TaskServices
    Date        : 29 Sep, 2016
    Author      :
    Description : This Helper for TaskTrigger and TaskBatch to update Last_Call_Date__c Field of Account Field According To Most Recent Phone-Call Task
**/

public class TaskServices{ 
    public TaskServices(){
    
    }
    // This Method is Call When Trigger is Fire on Insert Of Task
    public void onAfterInsert(List<Task> newTasks){
        Set<Id> accountIds= new Set<Id>();
        for(Task taskRecord: newTasks){
            // Set Of AccountId of which Task is Insert
            accountIds.add(taskRecord.WhatId);
        }    
            if(accountIds.size() >0){
                List<Account> accountList= getAccountsToUpdateRecentCallDateDate(accountIds);  
                if(accountList != null && accountList.size() >0){
                    // when record is insert in may be one of them is fail to insert 
                    //so in that time with the help of this method all the pass record will be inserted sucessfully
                    Database.update(accountList,false);
                }
            }                  
    }
    // This Method is Call When Trigger is Fire on Update Of Task
    public void onAfterUpdate(List<Task> taskList,Map<Id,Task> oldMap){
        Set<Id> accountIds = new Set<Id>();
        for(Task taskRecord:  taskList) {
            Task oldRecord = oldMap.get(taskRecord.id);
            // Check at the updation time if ActivityDate,AccountId and Status is Changed 
            if(taskRecord.ActivityDate != oldRecord.ActivityDate || taskRecord.WhatId != oldRecord.WhatId || taskRecord.Status == 'Completed'){
                accountIds.add(taskRecord.whatId);
                if(taskRecord.WhatId != oldRecord.WhatId) accountIds.add(oldRecord.whatId);
            }
        }
        if(accountIds.size() > 0){
            List<Account> accountList = getAccountsToUpdateRecentCallDateDate(accountIds); 
            if(accountList != null && accountList.size() > 0){
                Database.update(accountList,false);
            }
        }            
    }
    // Get accountList to be updated
    private List<Account> getAccountsToUpdateRecentCallDateDate(Set<Id> accountIds){
        List<Account> updateAccountList= new List<Account>(); 
        //Get the Map for Latest non-future event with Account id as map key.
        Map<String,Task> activityHistoryMap = getActivityHistoryMap(accountIds);
        for(Account acc: [Select id,last_Call_Date__c from Account where id IN:accountIds]){
            if(activityHistoryMap.containsKey(acc.id) && activityHistoryMap.get(acc.id) !=null){
                if(acc.Last_Call_Date__c != activityHistoryMap.get(acc.id).activitydate){
                    acc.Last_Call_Date__c= activityHistoryMap.get(acc.id).activitydate;
                    updateAccountList.add(acc);
                }
            }else{
                acc.Last_Call_Date__c= null;
                updateAccountList.add(acc);    
            }       
        }
        return updateAccountList;   
    }
    // This Method is Called to get map of Activityhisory 
    private Map<String,Task> getActivityHistoryMap(Set<Id> accountIds){
        Map<String,Task> activityHistoryMap = new Map<String,Task>();
        // Filter task according to most recent completed phone call 
        // Subject of task must be Like '%Call%' And Status of task is completed 
        for(Task taskRecord:  [Select id,whatid,status,activityDate from Task Where whatId IN :accountIds AND status= 'Completed' AND Subject Like '%Call%']){
            if(activityHistoryMap.containsKey(taskRecord.whatId) && activityHistoryMap.get(taskRecord.whatId) != null){
                if(activityHistoryMap.get(taskRecord.whatId).activityDate < taskRecord.activitydate){
                    activityHistoryMap.put(taskRecord.whatId,taskRecord);
                }                            
            }else{
                activityHistoryMap.put(taskRecord.whatId,taskRecord);
            }                    
        }
        return activityHistoryMap;        
    }
}