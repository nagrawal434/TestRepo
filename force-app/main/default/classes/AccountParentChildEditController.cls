public class AccountParentChildEditController{
    public string paramId;
    public List<String> contactIdes;
    public Set<String> contactSetIds;
    public List<ModelClass> modelList{get;set;}
    public List<SelectOption> countrieLst {get;set;}
    public String selectedCountry{get;set;}
    public Contact newContact{get;set;}
    public String accId;
    public AccountParentChildEditController(){
        newContact = new Contact();
        contactIdes= new List<String>();
        modelList=new List<ModelClass>();
        integer i=0;   
        paramId= ApexPages.currentPage().getParameters().get('Id');
        paramId=paramId.removeStart('{');
        paramId=paramId.removeEnd('}');
        paramId= paramId.deleteWhiteSpace();
        contactIdes=paramId.split(',');
        countrieLst = new List<SelectOption>();
        countrieLst.add(new SelectOption('','--None--'));
        countrieLst.add(new SelectOption('India','India'));
        countrieLst.add(new SelectOption('China','China'));
        countrieLst.add(new SelectOption('US','US'));
        List<Contact> conList= [select id,firstname,lastname,email,phone,accountId,LeadSource,birthdate from contact where id IN: contactIdes];
        for(Contact con: conList){
            ModelClass obj= new ModelClass();
            obj.contactChild= con;
            obj.serialNo=  ++i;
            modelList.add(obj);    
        }      
        if(modelList.size()>0)
            accId = modelList[0].contactChild.accountId;  
    }
    public pageReference saveContacts(){
        List<Contact> toBeUpdatedContacts= new List<Contact>(); 
        for(ModelClass m: modelList){
            toBeUpdatedContacts.add(m.contactChild);
        }
        if(toBeUpdatedContacts.size() >0){
            upsert toBeUpdatedContacts;            
        }     
        return new pageReference('/apex/LightningForm?id=' +accId).setRedirect(true);
    }
    public pageReference InSertNewContact(){
        newContact.accountId= accId;
        insert newContact;
        return new pageReference('/apex/LightningForm?id=' +accId).setRedirect(true);   
    } 
    public class ModelClass{
        public Contact contactChild{get;set;}
        public Integer serialNo{get;set;}
        public ModelClass(){
            contactChild= new Contact();
        }
    }        
}