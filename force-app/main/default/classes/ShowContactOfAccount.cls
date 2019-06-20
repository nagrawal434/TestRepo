public class ShowContactOfAccount{
    
    public List<contact> contactList{get;set;}
    public contact contactDetail{get;set;}
    public String contactId{get;set;}
    public String editContactId{get;set;}
    private List<contact> contacInserttList = new List<contact>();
    public Boolean showContact{get;set;}
    public Boolean editContact{get;set;}
    private set<id> contactIdSet = new set<id>();
    private String accountId;
    public ShowContactOfAccount(ApexPages.StandardController sc){
    
        accountId = sc.getRecord().id;
        contactList = new List<contact>();
        contactList = [select firstName,LastName,id from contact where AccountId = :accountId];
        contactDetail = new contact();
        contactDetail = [select firstname,LastName,Email,Phone,MobilePhone,MailingCity,MailingStreet,MailingCountry,MailingPostalCode,id from contact where AccountId = :accountId limit 1];
        showContact = true; 
    }
    
    public void showContactDetail(){
        
        system.debug('@@ contactId' + contactId);
        if(contactIdSet.size()>0){
            
            if(contactIdSet.contains(contactId)){
                
                showContact = false;  
                editContact = true;
                
            }else{
            
                showContact = true;  
                editContact = false;
            }
        }else{
            
                showContact = true;  
                editContact = false;
            }
        contactDetail = new contact();
        contactDetail = [select firstname,LastName,Email,Phone,MobilePhone,MailingCity,MailingStreet,MailingCountry,MailingPostalCode,id from contact where id =: contactId];

    }
    
    public void Addcontact(){
    
        contactDetail = new contact();
        contactDetail.AccountId = accountId;
        showContact = false;  
        editContact = true; 
    }
    public void editDetail(){
    
        contactIdSet.add(editContactId);
        showContact = false;  
        editContact = true;  
    }
    
    public void updateContact(){
    
        system.debug('@@@@@ editContactId' + editContactId); 
        upsert contactDetail id;
        if(contactIdSet.contains(contactDetail.id)){
            
            system.debug('@@@@@ contactDetail' + contactDetail.id); 
            contactIdSet.remove(editContactId);
        }else{
            
            contactList.add(contactDetail);
        }
        
        contactId = contactDetail.id;
        system.debug('@@@@@ contactDetail' + contactDetail);
        showContactDetail();
    }
}