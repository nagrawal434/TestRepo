@isTest

public class ContactAccountScoreTriggerTest{

      public static testMethod void ContactTest(){
          Set<Id> accIds= new Set<Id>(); 
          Account acc = new Account(name='Shine');
          insert acc;
          
          Account acc1 = new Account(name='Shine');
          insert acc1;
        
          Contact con = new Contact(lastname='sejal',AccountId=acc.id,Amount_X__c=1,Amount_Y__c=2);
          insert con;
          
          con.Amount_X__c= 3;
          con.Amount_Y__c= 2;
          con.AccountId=acc1.id;
          update con;
          
          accIds.add(acc.id);
          ContactAccountStoreHelper.insertUpdateAccountScore(accIds);
         
          delete con; 
    
      }

}