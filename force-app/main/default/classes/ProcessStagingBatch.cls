global class ProcessStagingBatch implements Database.Batchable<sObject>{
    public Map<String, Staging__c> stagingMap = new Map<String, Staging__c>();
    public Map<String, Id> contactIdMap = new Map<String, Id>();
    public Map<String, Staging__c> contactStageLookupMap = new Map<String, Staging__c>();
    public Map<String, Staging__c> accountStageMap = new Map<String, Staging__c>();
    public Map<String, Id> stagingAccountMap = new Map<String, Id>();
    public Map<String, Staging__c> stagingMapOppLook = new Map<String, Staging__c>();
    global ProcessStagingBatch(){
    
    }
    global Database.QueryLocator start(Database.BatchableContext Bc){
        List<Staging__c> sListtest = new List<Staging__c>(); 
        sListtest = [Select id,First_Name__c,Last_Name__c,Postal_Code__c,Individual_or_Organization__c,Amount__c,Orgganization_Name__c,Date_Recieved__c,Description__c from Staging__c where Individual_or_Organization__c != null];
        system.debug('%%' + sListtest);
        return Database.getQueryLocator('Select id,First_Name__c,Last_Name__c,Postal_Code__c,Individual_or_Organization__c,Amount__c,Orgganization_Name__c,Date_Recieved__c,Description__c from Staging__c where Individual_or_Organization__c != null'); 
    }
    global void execute(Database.BatchableContext Bc, List<Staging__c> stagingList){
        
        Set<String> MatchingSet = new Set<String>();
        Set<String> firstNameSet = new Set<String>();
        Set<String> lastNameSet = new Set<String>();        
        Set<String> postalCodeSet = new Set<String>();        
        Set<String> orgNameSet = new Set<String>();
        List<Contact> contactExistingList = new List<Contact>();
        Map<String, String> accountIdMap = new Map<String, String>();
        Map<String,Contact> contactLinkMap = new Map<String,Contact>(); 
        List<Contact> contactInsertList = new List<Contact>();
        List<Account> accountInsertList = new  List<Account>();
        Contact existContact = new Contact();
        for(Staging__c stagObj : stagingList){
            if(stagObj.First_Name__c != null && stagObj.Last_Name__c != null && stagObj.Postal_Code__c != null){
                firstNameSet.add(stagObj.First_Name__c);
                lastNameSet.add(stagObj.Last_Name__c);
                postalCodeSet.add(stagObj.Postal_Code__c);
                if(stagObj.Orgganization_Name__c != null)
                    orgNameSet.add(stagObj.Orgganization_Name__c);
            }    
        }
        for(Contact con : [select id, firstname, lastname, otherpostalcode from contact where firstname IN : firstNameSet AND lastname IN : lastNameSet AND otherpostalcode IN : postalCodeSet]){
            system.debug('### ' +con.firstname+ '-'+con.lastname + '-'+con.otherpostalcode);
            if(con.firstname != null && con.lastname != null && con.otherpostalcode != null){
                MatchingSet.add(con.firstname+'-' + con.lastname + '-'+con.otherpostalcode);
                contactLinkMap.put(con.firstname+'-' + con.lastname + '-'+con.otherpostalcode,con);
            }
            
        }
        
        for(Account acc : [select id, name, billingpostalcode from account where name IN : orgNameSet AND billingpostalcode IN : postalCodeSet]){
            if(acc.billingpostalcode != null)
                accountIdMap.put(acc.name+'-'+acc.billingpostalcode , acc.id);
        }
        for(Staging__c stagObj : stagingList){
            if(stagObj.Individual_or_Organization__c == 'I'){
                if(stagObj.First_Name__c != null && stagObj.Last_Name__c != null && stagObj.Postal_Code__c != null && !MatchingSet.contains(stagObj.First_Name__c+'-' + stagObj.Last_Name__c+ '-'+stagObj.Postal_Code__c)){
                    Contact con = new Contact();
                    con.accountid = accountIdMap.containsKey(stagObj.Orgganization_Name__c+'-'+stagObj.Postal_Code__c) ? accountIdMap.get(stagObj.Orgganization_Name__c+'-'+stagObj.Postal_Code__c) : null;
                    system.debug('come in method for Accountid' +con.accountid);
                    
                    con.firstname = stagObj.First_Name__c;
                    con.lastname = stagObj.Last_Name__c;
                    con.otherpostalcode = stagObj.Postal_Code__c;
                    contactInsertList.add(con);
                    stagingMap.put(stagObj.First_Name__c+'-' +stagObj.Last_Name__c+'-'+stagObj.Postal_Code__c, stagObj);
                    stagingMapOppLook.put(stagObj.First_Name__c+'-'+stagObj.Last_Name__c,stagObj);
                }
            } 
            if(stagObj.Individual_or_Organization__c == 'O'){   
                if(stagObj.Orgganization_Name__c != null && stagObj.Postal_Code__c != null && !accountIdMap.containsKey(stagObj.Orgganization_Name__c+'-'+stagObj.Postal_Code__c)){
                    Account acc = new Account(name = stagObj.Orgganization_Name__c, billingpostalcode =  stagObj.Postal_Code__c);
                    accountInsertList.add(acc);
                    accountStageMap.put(stagObj.Orgganization_Name__c+'-'+stagObj.Postal_Code__c,stagObj);
                    if(stagObj.Last_Name__c != null && stagObj.Postal_Code__c != null && contactLinkMap.containsKey(stagObj.First_Name__c+'-' +stagObj.Last_Name__c+'-'+stagObj.Postal_Code__c)){
                        stagingAccountMap.put(stagObj.Orgganization_Name__c+'-'+stagObj.Postal_Code__c, contactLinkMap.get(stagObj.First_Name__c+'-' +stagObj.Last_Name__c+'-'+stagObj.Postal_Code__c).id);
                        contactStageLookupMap.put(stagObj.Orgganization_Name__c+'-'+stagObj.Postal_Code__c,stagObj); 
                    }
                   
                }
           }
        }
        system.debug('contactInsertList ' + contactInsertList);
        if(contactInsertList.size() > 0){
            insert contactInsertList;            
            createOpportunity(contactInsertList);
        }
        if(accountInsertList.size() > 0){
            insert accountInsertList;
            linkAccount(accountInsertList,stagingAccountMap); 
        }
    
    }
    global void finish(Database.BatchableContext Bc){
        
    } 
    public void createOpportunity(List<Contact> contactList){
        Staging__c stageObj = new Staging__c();
        Staging__c stageOppObj = new Staging__c();
        List<Staging__c> stageObjList = new  List<Staging__c>();
        List<Staging__c> stageOppObjList = new  List<Staging__c>(); 
        List<Opportunity> oppList = new List<Opportunity>();
        List<OpportunityContactRole> oppConRoleList = new List<OpportunityContactRole>();
        for(Contact con : contactList){
            if(stagingMap.containsKey(con.firstname+'-'+con.lastname+'-'+con.otherpostalcode)){
                stageObj = stagingMap.get(con.firstname+'-'+con.lastname+'-'+con.otherpostalcode);
                stageObj.Contact__c = con.id;
                stageObj.Account__c = con.accountid;
                stageObjList.add(stageObj); 
                System.debug('Welcome' + stageObj.Contact__c);
                Opportunity opp = new Opportunity(closedate = stageObj.Date_Recieved__c,
                                                  name = con.firstname+'-'+con.lastname,
                                                  amount = stageObj.Amount__C,
                                                  Description = stageObj.Description__c,
                                                  StageName  = 'Closed',
                                                  accountid = con.accountid);
                contactIdMap.put(con.firstname+'-'+con.lastname, con.id);                                                  
                oppList.add(opp);                                                  
            }
        }
        if(stageObjList.size()>0){
            Update stageObjList;
        }
        if(oppList.size() > 0){
            insert oppList;
        }    
            for(Opportunity opp : oppList){
                if(stagingMapOppLook.containsKey(opp.name)){
                  stageOppObj = stagingMapOppLook.get(opp.name);
                  stageOppObj.Opportunity__c = opp.id;
                  stageOppObjList.add(stageOppObj);   
                }
                if(stageOppObjList.size() > 0){
                  Upsert stageOppObjList; 
                }
           }
           for(Opportunity opp : oppList){    
                if(contactIdMap.containsKey(opp.name)){
                    OpportunityContactRole oppConRole = new OpportunityContactRole(OpportunityId = opp.id, ContactId = contactIdMap.get(opp.name));
                    oppConRoleList.add(oppConRole);
                }
           }
            if(oppConRoleList.size() > 0){
                insert oppConRoleList;
            }
            
            
        
    }
    public void linkAccount(List<Account> accountInsertList,Map<String, Id> stagingAccountMap){
        List<Contact> contactList = new List<Contact>();
        List<Opportunity> OppAccList = new List<Opportunity>();   
        Staging__c stageAccountLookupObj = new Staging__c();
        Staging__c stageContactLookupObj = new Staging__c();
        List<Staging__c> stageAccountLookupObjList = new List<Staging__c>();
        List<Staging__c> stageContactLookupObjList = new List<Staging__c>();
        for(Account acc : accountInsertList){ 
           if(accountStageMap.containsKey(acc.name+'-'+acc.billingpostalcode)){
               stageAccountLookupObj = accountStageMap.get(acc.name+'-'+acc.billingpostalcode);
               stageAccountLookupObj.Account__c = acc.id;
               stageAccountLookupObjList.add(stageAccountLookupObj);
           }
        }
        if(stageAccountLookupObjList.size() >0){
            upsert stageAccountLookupObjList; 
        }
        for(Account acc : accountInsertList){
            if(acc.billingpostalcode != null && stagingAccountMap.containsKey(acc.name+'-'+acc.billingpostalcode)){
                Contact con = new Contact(Id=stagingAccountMap.get(acc.name+'-'+acc.billingpostalcode));
                stageContactLookupObj = contactStageLookupMap.get(acc.name+'-'+acc.billingpostalcode);
                stageContactLookupObj.Contact__c = con.id;
                stageContactLookupObjList.add(stageContactLookupObj);
                con.accountid =  acc.id;
                contactList.add(con);
            }
           if(accountStageMap.containsKey(acc.name+'-'+acc.billingpostalcode)){
               Staging__c stageObj = new Staging__c();
               stageObj = accountStageMap.get(acc.name+'-'+acc.billingpostalcode);
               Opportunity oppAcc = new Opportunity(closedate  = stageObj.Date_Recieved__c,
                                                    name = acc.name,
                                                    accountid = acc.id,
                                                    amount = stageObj.Amount__C,
                                                    StageName  = 'Opened',
                                                    description = stageObj.Description__c);
               OppAccList.add(oppAcc);                         
           }               
        }
        if(stageContactLookupObjList.size() >0){
            upsert stageContactLookupObjList;
        }
        if(contactList.size() > 0){
            update contactList;
        }
        if(OppAccList.size() > 0){
            insert OppAccList; 
        }
    } 
}