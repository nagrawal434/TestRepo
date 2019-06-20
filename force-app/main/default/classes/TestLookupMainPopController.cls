@isTest
public class TestLookupMainPopController{
    @isTest
    public static void test(){
        String accountId; 
        LookupMainController  Look = new  LookupMainController();
        Look.accountId='bdbjcbjcbvjxbcjvxb';
        Look.findContacts(); 
        LookupPopupController pop = new LookupPopupController();        
        pop.runQuery();
   } 
}