/**
    Name        : EventServices
    Date        : 29 Sep, 2016
    Author      :
    Description : This Helper for EventTrigger and EventBatch to update Last_Meeting_Date__c Field of Account Field
**/

public class EventServices{
    public EventServices(){
    }
    public void onAfterInsert(List<Event> eventList){
        Set<Id> accountIds = new Set<Id>();
        for(Event eventRecord:  eventList) {
            if(eventRecord.ActivityDate <= System.today()){
                accountIds.add(eventRecord.whatId);
            }
        }
        if(accountIds.size() > 0){
            List<Account> accountList = getAccountsToUpdateRecentMeetingDate(accountIds); 
            if(accountList != null && accountList.size() > 0){
                Database.update(accountList,false);
            }
        }               
    }
    public void onAfterUpdate(List<Event> eventList,Map<Id,Event> oldMap){
        Set<Id> accountIds = new Set<Id>();
        for(Event eventRecord:  eventList) {
            Event oldRecord = oldMap.get(eventRecord.id);
            if(eventRecord.ActivityDate != oldRecord.ActivityDate || eventRecord.WhatId != oldRecord.WhatId){
                accountIds.add(eventRecord.whatId);
                if(eventRecord.WhatId != oldRecord.WhatId) accountIds.add(oldRecord.whatId);
            }
        }
        if(accountIds.size() > 0){
            List<Account> accountList = getAccountsToUpdateRecentMeetingDate(accountIds); 
            if(accountList != null && accountList.size() > 0){
                Database.update(accountList,false);
            }
        }
    }
    private List<Account> getAccountsToUpdateRecentMeetingDate(Set<Id> accountIds){
        //Get the Map for Latest non-future event with Account id as map key.
        Map<String,Event> activityHistoryMap = getActivityHistoryMap(accountIds);
        List<Account> updateAccountList = new List<Account>();
        //Map<Id,Account> accMap = new Map<String.Account>([SELECT id,Last_Meeting_Date__c FROM ACCOUNT WHERE id in: accountIds]);
        for(Account acc: [SELECT id,Last_Meeting_Date__c FROM ACCOUNT WHERE id in: accountIds]){
            if(activityHistoryMap.containsKey(acc.id) && activityHistoryMap.get(acc.id) != null){
                if(acc.Last_Meeting_Date__c != activityHistoryMap.get(acc.id).ActivityDate){
                    acc.Last_Meeting_Date__c = activityHistoryMap.get(acc.id).ActivityDate;
                    updateAccountList.add(acc);
                }
            }else{
                acc.Last_Meeting_Date__c = null;
                updateAccountList.add(acc);
            }
        } 
        return updateAccountList;
    }
    
    private Map<String,Event> getActivityHistoryMap(Set<Id> accountIds){
        Map<String,Event> activityHistoryMap = new Map<String,Event>();
        if(accountIds != null && accountIds.size() > 0){
            For(Event eventRecord : [Select id,ActivityDate,WhatId from Event where WHATID IN :accountIds AND ActivityDate <= TODAY]){
                if(activityHistoryMap.containskey(eventRecord.whatid) && activityHistoryMap.get(eventRecord.whatid) != null){
                    if(activityHistoryMap.get(eventRecord.whatid).ActivityDate < eventRecord.ActivityDate){
                        activityHistoryMap.put(eventRecord.whatid,eventRecord);
                    }
                }else{
                    activityHistoryMap.put(eventRecord.whatid,eventRecord);
                }
            }
        }
        return activityHistoryMap;
    }
     
}