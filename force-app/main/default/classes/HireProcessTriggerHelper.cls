public class HireProcessTriggerHelper{
    public static void createNewContactCase(List<Hire_Form__c> hireProcessList){
        List<Hire_Form__c> hireObjList = new List<Hire_Form__c>();
        Map<String,Hire_Form__c> HireForContactMap = new Map<String,Hire_Form__c>(); 
        List<Contact> conList = new List<Contact>();
        for(Hire_Form__c hireobj : hireProcessList){
            if(hireobj.Status__c == null){
               hireobj.Status__c = 'In Progress';
               Contact conObj = new Contact();
               conObj.firstname = hireobj.First_Name__c;
               conObj.lastname = hireobj.Last_name__c;
               conObj.email = hireobj.Email__c;
               conObj.phone = hireobj.Phone__c;
               conList.add(conObj);
               HireForContactMap.put(hireobj.First_Name__c+'-'+hireobj.Last_name__c+'-'+hireobj.Email__c+'-'+hireobj.Phone__c,hireobj); 
            }
        }
        if(conList.size() >0){
            upsert conList;
        } 
        LinkNewContact(conList,HireForContactMap);
    } 
    public static void LinkNewContact(List<Contact> conList,Map<String,Hire_Form__c> HireForContactMap){
        Map<Id,Case> CaseMap = new Map<Id,Case>();
        Hire_Form__c obj = new Hire_Form__c();
        List<Case> caseobjList = new List<Case>();
        Case caseMapObj = new Case();
        for(Contact c: conList){
           if(HireForContactMap.containsKey(c.firstname+'-'+c.lastname+'-'+c.email+'-'+c.phone)){
                obj =  HireForContactMap.get(c.firstname+'-'+c.lastname+'-'+c.email+'-'+c.phone);
                obj.Candidate__c = c.id;
                Case caseObj = new Case(contactid = c.id,
                                        status = 'New',
                                        origin = 'Phone');
                                     
                caseobjList.add(caseObj);
                CaseMap.put(c.id,caseObj);
            }
        }
        if(caseobjList.size() > 0){
            upsert caseobjList;
        }
      }
     public static void UpdateMethod(List<Hire_Form__c> hireProcessList){
         Set<String> setContactd = new Set<String>();
         List<Case> caseList = new List<Case>();
         List<Case> updateCaselist = new List<Case>(); 
         for(Hire_Form__c hf : hireProcessList){
             if(hf.Status__c == 'Completed'){
                   setContactd.add(hf.Candidate__c); 
             }
          }
          caseList  = [select id,contactid from Case order by createdDate desc];
          for(Case cs : [select id,status,contactid from Case where contactid IN : setContactd]){
                 cs.status = 'Closed';
                 updateCaselist.add(cs);
            } 
            update updateCaselist;
          
     }
     public static void BeforeCaseUpdate(List<Case> CaseList){
         Map<Id,Case> CaseContactMap = new Map<Id,Case>();
         Set<Id> CaseConatctIdSet = new Set<Id>();
         Set<String> ContactHireSet = new Set<String>();
         Case CaseMapObj = new Case();
         for(Case caseObj : CaseList){
             if(caseObj.status == 'Completed'){
                 CaseContactMap.put(caseObj.contactId,caseObj);
                 CaseConatctIdSet.add(caseObj.contactId);
             }   
         } 
         for(Contact con : [Select id from Contact Where Id IN: CaseConatctIdSet]){
             ContactHireSet.add(con.id);    
         }
         for(Hire_Form__c h : [Select id,Status__c from Hire_Form__c where Candidate__c IN : ContactHireSet]){
             CaseMapObj =  CaseContactMap.get(h.Candidate__c);
             if(!(h.Status__c == 'Completed')){
                 CaseMapObj.status.addError('You can not close the case until hire form  is completed');       
             }
         } 
         
         
     }
      
}