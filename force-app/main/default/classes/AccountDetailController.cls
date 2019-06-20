public class AccountDetailController{
     public Account accDetail{get;set;}
     public Contact contactlist{get;set;}
     
     
        public AccountDetailController(Apexpages.StandardController acc)
        {
               contactlist = new Contact();
               accDetail = new Account();
               accDetail = (Account)acc.getRecord();
         
        } 
        public pageReference save(){
                 
               contactlist.accountid = accDetail.id;
               Insert contactlist;
               return new pageReference('/apex/AccountDetail').setRedirect(true);
        }   
    

}