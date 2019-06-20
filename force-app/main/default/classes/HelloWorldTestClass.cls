@isTest
    private class HelloWorldTestClass {
        static testMethod void validateHelloWorld() {
           Account b = new Account(Name='Behind the Cloud', AccountNumber='12234');
           System.debug('Price before inserting new book: ' + b.AccountNumber);
     
           // Insert book
           insert b;
         
           // Retrieve the new book
           b = [SELECT AccountNumber FROM Account WHERE Id =:b.Id];
           System.debug('Price after trigger fired: ' + b.AccountNumber);
     
           // Test that the trigger correctly updated the price
           //System.assertEquals('12345', b.AccountNumber);
        }
    }