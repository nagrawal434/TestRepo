public Class SendEmailPdfController{
    public String enterAccount{get;set;}
    public List<Account> accountList;
    Public Boolean pbk1{get;set;}
    public Boolean pbk2{get;set;}
    public Boolean pbk3{get;set;}
    public Boolean isCheck{get;set;}
    public String AccountId{get;set;}
    public Boolean chkForSendMail{get;set;}
    public String selectedAccountId{get;set;}
    public List<ModelClass> ModelList{get;set;}
    public List<ModelClass> ModelContactList{get;set;}
    public List<Contact> ModelPdfContactList{get;set;}
    public String ContactIds{get;set;}
    public SendEmailPdfController(){
        accountList = new List<Account>();
        pbk1 = true;
        pbk2 = false;
        pbk3 = false;
    } 
    public void searchAccount(){
        pbk2 = true;
        ModelList = new List<ModelClass>();
        accountList = [select id,name,phone from Account WHERE name LIKE : enterAccount+'%'];
        system.debug('@@@' +enterAccount);
        system.debug('@@@' +accountList);
        for(Account a: accountList){
            ModelClass obj = new ModelClass();
            obj.AccountModel = a;
            ModelList.add(obj);
        }
     }
     public void selectContacts(){
        pbk3 = true;
        ModelContactList = new List<ModelClass>(); 
        String selAccountId = System.currentPagereference().getParameters().get('accountId'); 
        for(Contact c : [Select id,firstname,lastname,phone,email from Contact Where accountid = :selAccountId]){
            ModelClass obj = new ModelClass();
            obj.isCheck = false;
            obj.ContactModel = c;
            ModelContactList.add(obj);   
        
        }
    }    
    public pageReference sendEmail(){
          return new pageReference('/apex/SendEmailPdfPage');
               
    }
    public void sendMethod(){
        system.debug('@@');
        chkForSendMail = false;
        for(ModelClass ms : ModelContactList){
            if(ms.isCheck == true){
                chkForSendMail = true;
                ContactIds += ms.ContactModel.id + ',';
            }
        }
         if(chkForSendMail == false){
              apexpages.addmessage(new Apexpages.Message(ApexPages.Severity.Error,' Please Select any contact'));
        }else
            ContactIds = ContactIds.removeStart('null');   
    }
    public void attachFileMethod(){
    }
    public void cancelMethod(){
    }
    public pageReference printEmail(){
        ModelPdfContactList = new List<Contact>(); 
        for(ModelClass m: ModelContactList){
            if(m.isCheck == true){
               ModelPdfContactList.add(m.ContactModel);
               system.debug('##' + m.ContactModel);
            }
        }
          return new pageReference('/apex/SendPdfRenderdpage');
           
    }
    public Class ModelClass{
        public Contact ContactModel{get;set;}
        public Account AccountModel{get;set;}
        public Boolean isCheck{get;set;}
        public ModelClass(){
            ContactModel = new Contact(); 
            AccountModel = new Account();  
        }
    }
}