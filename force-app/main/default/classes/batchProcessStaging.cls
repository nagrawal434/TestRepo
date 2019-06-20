global class batchProcessStaging implements Database.Batchable<sObject>{
   global Map<String,Contact> ContactMap;
   global Map<String,Account> AccountMap;
   global Map<String,Opportunity> OpportunityMapforContact;
   global Map<String,Contact> ContactMapForOpprtunity;
   global Map<String,Staging__c> StagingMapForContactLookup;
   global batchProcessStaging(){
        ContactMap = new Map<String,Contact>();
        AccountMap = new Map<String,Account>();  
        OpportunityMapforContact = new Map<String,Opportunity>();
        ContactMapForOpprtunity = new Map<String,Contact>(); 
        StagingMapForContactLookup = new Map<String,Staging__c>(); 
   }
    global Database.QueryLocator start(Database.BatchableContext Bc){
       return Database.getQueryLocator('Select id,First_Name__c,Last_Name__c,Postal_Code__c,Individual_or_Organization__c,Amount__c,Orgganization_Name__c,Date_Recieved__c,Description__c from Staging__c limit 2000'); 
    }
    global void execute(Database.BatchableContext Bc, List<sObject> scope){
    List<Staging__c> stageList =  (List<Staging__c>)scope;
    List<Contact> conList = new List<Contact>();
    List<Account> accList = new  List<Account>();
    List<Contact> NewContactList = new List<Contact>();
    List<Contact> NewContactList2 = new List<Contact>();
    List<Opportunity> oppList = new List<Opportunity>();
    OpportunityContactRole objContactRole = new OpportunityContactRole();
    List<OpportunityContactRole> objContactRoleList = new List<OpportunityContactRole>();  
    Boolean flag = false;
    Account ac = new Account();
    Contact con =new Contact();
    Contact ConObjOpp = new Contact();
    Opportunity oppRoleobj = new Opportunity();
    List<Account> accountList = new List<Account>(); 
    conList = [Select id,firstname,lastname,otherpostalcode from Contact];
    accList = [Select id,name,billingpostalcode,Orgganization_Name__c from Account];
    oppList = [select id,name from Opportunity];
    for(Contact c : conList)
    {
        ContactMap.put(c.firstname+'/'+c.lastname+'/'+c.otherpostalcode,c);
        ContactMapForOpprtunity.put(c.firstname,c);
    }
    for(Account a : accList)
    {
        AccountMap.put(a.name+'/'+a.billingpostalcode,a);
    } 
    for(Opportunity o :oppList)
    {
        OpportunityMapforContact.put(o.name,o);     
    }
    
    for(Staging__c s : stageList)
    {
      if(s.Individual_or_Organization__c == 'I')
      {
           
           if(!ContactMap.containsKey(s.First_Name__c+'/'+s.Last_Name__c +'/'+s.Postal_Code__c))
            {
                System.debug('%%%%%' +s);
                Contact c = new Contact();
                c.firstname = s.First_Name__c;
                c.lastname = s.Last_Name__c;
                c.otherpostalcode = s.Postal_Code__c;
                StagingMapForContactLookup.put(s.First_Name__c+'/'+s.Last_Name__c +'/'+s.Postal_Code__c,s);
                if(AccountMap.containsKey(s.Orgganization_Name__c+'/'+s.Postal_Code__c))
                {
                  ac = AccountMap.get(s.Orgganization_Name__c+'/'+s.Postal_Code__c);
                  c.accountid = ac.id;
                } 
                
                    ConObjOpp = ContactMapForOpprtunity.get(s.First_Name__c); 
                    Opportunity OppObj = new Opportunity();
                    OppObj.name = ConObjOpp.firstname;
                    OppObj.closedate = s.Date_Recieved__c;
                    OppObj.amount = s.Amount__c;
                    OppObj.description =s.Description__c;
                    OppObj.stagename = 'teststage';
                    if(OpportunityMapforContact.containsKey(ConObjOpp.firstname))
                    {
                        oppRoleobj = OpportunityMapforContact.get(ConObjOpp.firstname);
                        objContactRole.ContactId = ConObjOpp.id;
                        objContactRole.OpportunityId = oppRoleobj.id;
                        objContactRole.IsPrimary=true;
                        objContactRole.Role='CEO';
                    }
                    objContactRoleList.add(objContactRole);
                    oppList.add(OppObj); 
                    NewContactList.add(c);
           }
      }
      if(s.Individual_or_Organization__c == 'O')
      {
          if(!AccountMap.containsKey(s.Orgganization_Name__c+'/'+s.Postal_Code__c))
          {
               Account NewAccount = new Account();
               NewAccount.Name = s.Orgganization_Name__c;
               NewAccount.billingpostalcode = s.Postal_Code__c;
               if(ContactMap.containsKey(s.Last_Name__c+'/'+s.Postal_Code__c))
               {
                   con = ContactMap.get(s.Last_Name__c+'/'+s.Postal_Code__c);
                   con.accountid = NewAccount.id;
                   NewContactList2.add(con);
               }
             accountList.add(NewAccount);         
           }
     }
    }
    
    if(NewContactList.size()>0)
    {
        System.debug('Welcome');
        insert NewContactList;
        System.debug('Welcome' +NewContactList);
        createLookup(NewContactList);
    }
    if(accountList.size()>0)
    {
         insert accountList; 
    }
    if(NewContactList2.size()>0)
    {
        upsert NewContactList2;
    } 
    if(oppList.size()>0)
    {
        insert oppList;
    }
    if(objContactRoleList.size()>0)
    {
        insert objContactRoleList; 
    } 
    }
    public void createLookup(List<Contact> NewContactList){
        Staging__c stagObj = new Staging__c();
        System.debug('Lookup');
        for(Contact c: NewContactList){
            if(StagingMapForContactLookup.containsKey(c.firstname+'-'+c.lastname+'-'+c.otherpostalcode)){
               System.debug('In Condition' +c.id);
               stagObj = StagingMapForContactLookup.get(c.firstname+'-'+c.lastname+'-'+c.otherpostalcode);
               stagObj.Contact__c =c.id;    
            }
        }
        
    } 
        global void finish(Database.BatchableContext Bc){
    } 
    }