public class MemoManagerController{
    public String e1{get;set;}
    public String p1{get;set;}
    public String f1{get;set;}
    public String l1{get;set;}
    public String newemail{get;set;}
    public List<Contact> conlist{get;set;}
    public String newPassword{get;set;}
    public List<Memos__c> memoList{get;set;}
    public Contact con{get;set;}
    public List<Memos__c> memoEditList{get;set;}
    public String rowMemoId{get;set;}
    public Memos__c memoCreate{get;set;}  
    public String contactId{get;set;}
    public List<Memos__c> memoSiteList{get;set;}  
    public MemoManagerController(){
        con = new Contact();
        memoCreate = new Memos__c(); 
        memoEditList = new List<Memos__c>(); 
        memoEditList.add(memoCreate);
        memoSiteList = new List<Memos__c>(); 
        memoSiteList = [Select MemoName__c,Status__c,DiscriptionMemo__c from Memos__c Where Status__c='Publish'];
        system.debug('****' + memoSiteList);
        if(ApexPages.currentPage().getParameters().get('userid') != null)
        {
            contactId = ApexPages.currentPage().getParameters().get('userid');
        }
        String mid = ApexPages.currentPage().getParameters().get('memoid');
        if(mid != null)
       {
           memoEditList = [Select MemoName__c,Status__c,DiscriptionMemo__c from Memos__c Where id =:  mid];
           
       }
       else
       {
          memoList = [Select id,MemoName__c,Status__c,DiscriptionMemo__c from Memos__c Where Contact__c =: contactId];
       } 
          
      }
    public pageReference loginPage(){
         conlist = [Select id,email,password__c from Contact];
         for(Contact c : conlist){
            if(c.email == e1 && c.password__c == p1) //Matching email and passwrd
            {    
                return new pageReference('/apex/MemoManagerMemolistPage?userid=' + c.id).setRedirect(True);
            }
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter Valid Email or Password')); // error message show
        } 
    }
    return null;   
    }
    public pageReference editMemo(){
        return new pageReference('/apex/MemoManagerEditMemoPage?memoid=' + rowMemoId +'&userid=' + contactId).setRedirect(True);    
    }
    public pageReference NewUser(){
       return new pageReference('/apex/MemoManagerNewUserPage').setRedirect(True);
    }
    public pageReference saveNewUserPage(){
        if(con.lastname !=l1)
        {
        insert con;
        }
        return new pageReference('/apex/MemoManagerLoginPage').setRedirect(True);
    }
    public pageReference Savememo(){
       if(memoEditList.size()>0)
       {
           memoEditList.get(0).Contact__c = contactId;
           upsert memoEditList;
           return new pageReference('/apex/MemoManagerMemolistPage?userid=' +contactId).setRedirect(True);
       }
       else return null;
    }
    public pageReference Create(){
       return new pageReference('/apex/MemoManagerEditMemoPage?userid=' +contactId).setRedirect(True);  
      
    }   
}