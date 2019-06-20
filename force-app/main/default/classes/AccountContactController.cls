public class AccountContactController{
    public List<Contact> contacts{get;set;}
    public Map<String, List<Contact>> contactmap{get;set;}
    public List<AccountModel> model{get;set;}
    public List<Contact> contlist{get;set;}
    public List<Account> aclist{get;set;}
    public List<Contact>  templist{get;set;}
    public List<AccountModel> models{get;set;}
    
    
    public AccountContactController(){
           contactMap = new Map<String, list<Contact>>();
           // Set<Id> accountId = new Set<Id>();
           List<Contact> contlist = new List<Contact>();
           List<Account> aclist= new List<Account>();
           List<Contact> templist = new List<Contact>();
           models = new List<AccountModel>();
           aclist =[Select id,name from Account];
           Set<String> ids = new Set<String>();
           for(Account ac : aclist){
               ids.add(ac.id);
           }
           
           
           contlist = [Select Id,firstname,name,lastname,phone,email,accountid from Contact Where accountid IN:ids ];
                
           for(Contact c: contlist){
           
                   contacts = contactMap.get(c.accountid);
                   if(contacts == null)
                   {
                       contacts = new List<Contact>(); 
                   }                                   
                   contacts.add(c);
                    
                   contactMap.put(c.accountid,contacts);
                   // system.debug('$$$'+contactMap);
           }
              // system.debug(contactMap);
          
               
          
          
           for(account acc : aclist)
           {  
               AccountModel objm= new AccountModel();
               objm.accountname= acc.name;      
               if(contactMap.containskey(acc.id)){
                    
                     objm.modelContsList = contactMap.get(acc.id);
                    
               }
               
                 models.add(objm); 
           }
                 System.debug(models);
           
   }

     public class AccountModel{
          public List<Contact> ModelContsList{get;set;}
          public String accountName{get;set;}
          public AccountModel(){
             ModelContsList = new List<Contact>();
             
             
             
     
       }   
    
    
   }

}