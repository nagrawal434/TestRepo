public with sharing class RemoteActionCaseNotificationsController {
    
    @RemoteAction
    public static Case returnCase(string caseId){
        return [SELECT Id, caseNumber, status, priority, owner.name, account.name, contact.name,subject FROM Case WHERE Id = :caseId];
        
    }

}