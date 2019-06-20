@isTest
public class TestInLineVfPageActContController{
    @isTest
    private static void pageTestMethod(){
      Account a =new Account(name = 'dd');
      insert a;
      Contact c = new Contact(lastname = 'dd');
      insert c;
      Apexpages.StandardController std = new Apexpages.StandardController(a);
      AccountDetailController obj = new AccountDetailController(std);
      obj.contactlist.lastname = 'dd'; 
      obj.save();
    }

}