public class CandidateTriggerHelper{
    
    public static void createAccount(List<Condidate__c> candidateList){
        Map<String,Condidate__c> CandidateBrockageMap = new  Map<String,Condidate__c>();
        Map<String,Condidate__c> ContactBrockageMap = new Map<String,Condidate__c>();
        List<Account> accList = new List<Account>(); 
        for(Condidate__c c : candidateList){
            if(c.Brokerage__c != null){
                  Account a = new Account();
                  a.name = c.Brokerage__c;
                  accList.add(a);     
            }
            if(c.Brokerage__c  != null && c.Manage_Brokerage__c != null)
            {
                CandidateBrockageMap.put(c.Brokerage__c,c);
                ContactBrockageMap.put(c.Manage_Brokerage__c,c);    
            }
        }
        if(accList.size() > 0){
            insert accList;
            createAnotherAccount(accList,CandidateBrockageMap,ContactBrockageMap);
            }
     }
     public static void createAnotherAccount(List<Account> accList,Map<String,Condidate__c> CandidateBrockageMap,Map<String,Condidate__c> ContactBrockageMap){
        system.debug('@@');
        List<Account> anotherAccountList = new List<Account>();
        List<Contact> NewContactBrokerageList = new List<Contact>();
        List<Task> taskList = new List<Task>(); 
        Condidate__c accountCandidateObj = new Condidate__c();
        Condidate__c contactCandidate = new Condidate__c();
        for(Account a : accList){ 
            system.debug('welcome for another account');
        system.debug('@@@' + CandidateBrockageMap);
        if(CandidateBrockageMap.containsKey(a.name)){
            system.debug('welcome in another account');
            accountCandidateObj = CandidateBrockageMap.get(a.name);
            Account anotherAccount = new Account();
            anotherAccount.name = accountCandidateObj.Manage_Brokerage__c;
            anotherAccount.parentId = a.id;
            anotherAccountList.add(anotherAccount);
        }
        
        } 
        if(anotherAccountList.size() > 0){
            insert anotherAccountList;
        }
        for(Account anotherObj: anotherAccountList){ 
            system.debug('welcome for contact');
        system.debug('###' + ContactBrockageMap);
        if(ContactBrockageMap.containsKey(anotherObj.name)){
                    system.debug('welcome in contact');
            contactCandidate = ContactBrockageMap.get(anotherObj.name);
                    Contact c = new Contact();
                    c.lastname = anotherObj.name;
                    c.accountid = anotherObj.id;
                    c.Candidate__c = contactCandidate.id; 
                NewContactBrokerageList.add(c);
         }
        }
        if(NewContactBrokerageList.size() > 0){
            insert NewContactBrokerageList;
        }
        for(Contact Contaskobj : NewContactBrokerageList){
                system.debug('**'+Contaskobj);
                Task task = new Task();
                task.WhoId = Contaskobj.id;
                task.WhatId = Contaskobj.Candidate__c; 
                task.Subject = 'Portal Contact Setup';
                taskList.add(task);
         } 
        if(taskList.size() >0){
            insert taskList; 
        }
    }
}