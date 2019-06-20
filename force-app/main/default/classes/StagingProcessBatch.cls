global class StagingProcessBatch implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext Bc){
        string query = 'Select id, First_Name__c, Last_Name__c, Postal_Code__c FROM Staging__c'; 
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext Bc, List<Staging__c> stagingList){
        Set<String> firstNameSet = new Set<String>();
        Set<String> lastNameSet = new Set<String>();
        Set<String> postalCodeSet = new Set<String>();
        Map<String,Contact> existingContactMap = new Map<String,Contact>();         
        for(Staging__c stageRecord : stagingList){
            if(String.isNotBlank(stageRecord.First_Name__c) && String.isNotBlank(stageRecord.Last_Name__c) && String.isNotBlank(stageRecord.Postal_Code__c)){
                firstNameSet.add(stageRecord.First_Name__c);
                lastNameSet.add(stageRecord.Last_Name__c);
                postalCodeSet.add(stageRecord.Postal_Code__c); 
            }          
        }
        for(Contact con : [SELECT Id, FirstName, LastName, MailingPostalCode FROM CONTACT WHERE FirstName IN : firstNameSet 
                                                                                               AND lastName IN: lastNameSet
                                                                                               AND MailingPostalCode IN :postalCodeSet]){                            
            existingContactMap.put(con.FirstName+','+con.LastName+','+con.MailingPostalCode,con);        
        } 
        for(Staging__c stageRecord : stagingList){
            if(String.isNotBlank(stageRecord.First_Name__c) && String.isNotBlank(stageRecord.Last_Name__c) && String.isNotBlank(stageRecord.Postal_Code__c)){
                //if(existingContactMap.containsKey)
            
            }            
        }      
    }
    global void finish(Database.BatchableContext Bc){
        
    }    
}