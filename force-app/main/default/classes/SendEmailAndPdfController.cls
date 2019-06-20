public class SendEmailAndPdfController{

    public String accountName{get;set;}
    public List<account> accountList{get;set;}
    public Boolean accountDetail{get;set;}
    public Boolean contactDetail{get;set;}
    public String accountId{get;set;}
    public List<ContactModel> modelList{get;set;}
    public List<ContactModel> newModelList{get;set;}
    public String selectOption{get;set;}
    public Boolean checker{get;set;}
    private integer n;
    public Boolean viewNext{get;set;}
    public Boolean viewPre{get;set;}
    public String contactIdList{get;set;}
    public Boolean viewPagination{get;set;}
    public SendEmailAndPdfController(){

        system.debug('@@@@ newModelList' + newModelList);
        modelList = new List<ContactModel>();
        newModelList = new List<ContactModel>();
        
    }
    public void searchAccount(){
        
        contactDetail = false;
        string name = '%' + accountName + '%';
        accountList = [select name,phone from account where name like: name];
        accountDetail = true;
        
        if(newModelList.size() > 0)
            newModelList.clear();
    }
    public void showContactDetail(){
        selectOption = 'All';
        if(newModelList.size() > 0)
            newModelList.clear();
        if(modelList.size() > 0)
            modelList.clear();
        for(contact con : [select FirstName,LastName,Email,Phone from contact where AccountId =: accountId]){
        
            ContactModel model = new ContactModel();
            model.con = new contact();
            model.con = con;
            model.index = modelList.size();
            modelList.add(model);
            newModelList.add(model);
        }
        if(modelList.size() == 0){
            apexpages.addmessage(new Apexpages.Message(ApexPages.Severity.Info,' There is no contact for this account'));
            contactDetail = false;
        }
        else
            contactDetail = true;
        viewPagination = false;
           
    }
    public void changeOption(){
        
        system.debug('@@@@ inside' + modelList.size());
        if(newModelList.size() > 0)
            newModelList.clear();
        if(selectOption == 'All'){
            newModelList.addAll(modelList);
            viewPagination = false;
        }else if(selectOption == '10'){
            for(integer i = 0 ; i<integer.valueOf(selectOption); i++){
                if(modelList.size() >= i+1)
                    newModelList.add(modelList[i]);
            }
            if(modelList.size() <= 10)
                viewPagination = false;
            else{
                viewPagination = true;
                viewPre = true;
                viewNext = false;
                n = 10;
            }
        }else if(selectOption == '5'){
            for(integer i = 0 ; i<integer.valueOf(selectOption); i++){
                if(modelList.size() >= i+1)
                    newModelList.add(modelList[i]);
            }
            if(modelList.size() <= 5)
                viewPagination = false;
            else{
                viewPagination = true;
                viewPre = true;
                viewNext = false;
                n = 5;
            }
        }
    }
    public void nextCon(){
        newModelList.clear();
        integer k = n;
        system.debug('@@@@ ' + selectOption);
        integer j = n + integer.valueOf(selectOption);
        n = n + integer.valueOf(selectOption);
        system.debug('@@@@ j ' + j);
        system.debug('@@@@ k ' + k);
        if(j >= modelList.size()){
        
            j = modelList.size();
            viewNext = true; 
            
        }
        for(integer i=k;i<j;i++){
              newModelList.add(modelList[i]);
              system.debug('@@@@ i ' + i);
        } 
        viewPre = false; 
    }
    public void previousCon(){
        newModelList.clear();
        viewPre = false;
        n = n-integer.valueOf(selectOption);
        integer k = n-integer.valueOf(selectOption);
        integer j = n;
        
        if(k == 0){
            viewPre = true;
            n = integer.valueOf(selectOption);
        }
        for(integer i=k;i<j;i++){
              newModelList.add(modelList[i]);
        }
        viewNext = false;
    }
    public void showContactAsPdf(){
        
        checker = false;
        for(ContactModel model : newModelList){
            if(model.flag == true){
                checker = true;
                contactIdList += model.con.id + ',';
            }
        }
        system.debug('@@' + checker);
        if(checker == false){
            apexpages.addmessage(new Apexpages.Message(ApexPages.Severity.Error,' Please Select any contact'));
        }else
          contactIdList = contactIdList.removeStart('null');
    }
    public void sendMailToContcat(){
        
        checker = false ;
        system.debug('@@@@ checker' + checker);
        for(ContactModel model : modelList){
            if(model.flag == true){
                checker = true;
                contactIdList += model.con.id + ',';
            }
        }
        if(checker == false){
            
            apexpages.addmessage(new Apexpages.Message(ApexPages.Severity.Error,' Please Select any contact'));
        }else
            contactIdList = contactIdList.removeStart('null');
        system.debug('@@@@ contactIdList' + contactIdList);
        
    }
     public List<SelectOption> getoptions(){
        List<SelectOption> option = new List<SelectOption>();
        option.add(new SelectOption('All','All'));
        option.add(new SelectOption('5','5'));
        option.add(new SelectOption('10','10'));
        return option;
    }
    public class ContactModel{
    
        public contact con{get;set;}
        public Boolean flag{get;set;}
        public integer index{get;set;}
    }
    public void emptyIds(){
        system.debug('@@@@ + contactIdList' + contactIdList);
        contactIdList = '';
        system.debug('@@@@ + contactIdList' + contactIdList);
    }

}