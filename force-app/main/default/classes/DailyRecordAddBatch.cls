global class DailyRecordAddBatch implements Database.Batchable<sObject>{
    public Map<String,Contact> PrimaryContactNameEmailMap;
    public Map<String,Contact> SecondaryContactNameEmailMap;
    global DailyRecordAddBatch(){
        
    }
    global Database.QueryLocator start(Database.BatchableContext Bc){
        
        return Database.getQueryLocator('Select id,name,email,phone,otherpostalCode from Contact Where name !=null AND email != null Order By CreatedDate ASC'); 
    }
    global void execute(Database.BatchableContext Bc, List<Contact> contactList){
        PrimaryContactNameEmailMap = new Map<String,Contact>();
        SecondaryContactNameEmailMap = new  Map<String,Contact>();
        List<Contact> listToUpdated= new List<Contact>();
        List<Contact> listToDeleted = new List<Contact>(); 
        System.debug('contactlist' + contactList);
        for(Contact c : contactList){
            if(!PrimaryContactNameEmailMap.ContainsKey((c.name.toLowerCase()+'-'+c.email.toLowerCase()))){
                PrimaryContactNameEmailMap.put((c.name.toLowerCase()+'-'+c.email.toLowerCase()),c);    
            } 
            else{
                 SecondaryContactNameEmailMap.put((c.name.toLowerCase()+'-'+c.email.toLowerCase()),c);   
            }
        }
        System.debug('@@@' + PrimaryContactNameEmailMap);          
        System.debug('###' + SecondaryContactNameEmailMap);  
        for(String s : PrimaryContactNameEmailMap.keySet()){
            Contact updateCon = new Contact(); 
            Contact deleteCOn = new Contact();
            if(SecondaryContactNameEmailMap.ContainsKey(s)){
                system.debug('%%%' + PrimaryContactNameEmailMap.get(s).id);
                updateCon.id = PrimaryContactNameEmailMap.get(s).id; 
                deleteCOn.id = SecondaryContactNameEmailMap.get(s).id; 
                if(SecondaryContactNameEmailMap.get(s).phone == null){
                     updateCon.phone = PrimaryContactNameEmailMap.get(s).phone;   
                }
                else{
                    updateCon.phone = SecondaryContactNameEmailMap.get(s).phone;
                }
                if(SecondaryContactNameEmailMap.get(s).otherpostalCode == null){
                     updateCon.otherpostalCode = PrimaryContactNameEmailMap.get(s).otherpostalCode;   
                }
                else{
                    updateCon.otherpostalCode = SecondaryContactNameEmailMap.get(s).otherpostalCode;
                }
                listToUpdated.add(updateCon); 
                listToDeleted.add(deleteCOn);  
            }    
        }
        System.debug('!!!' + listToUpdated);
        System.debug('&&&' + listToDeleted);
        if(listToUpdated.size() > 0){
            update listToUpdated;
        }
        if(listToDeleted.size() > 0){
            delete listToDeleted;
        }    
     }
    global void finish(Database.BatchableContext Bc){
            
    }
}