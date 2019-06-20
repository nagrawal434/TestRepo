@IsTest
private class AccountManagerTest{

    @isTest static void testAccountManager() {
        Id recordId = createTestRecord();
        
        Contact objCont = new Contact();
        objCont.LastName = 'Test1';
        objCont.AccountId = recordId ;
        insert objCont ;
        
        Contact objCont2 = new Contact();
        objCont2 .LastName = 'Test2';
        objCont2 .AccountId = recordId ;
        insert objCont2 ;
        
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://na1.salesforce.com/services/apexrest/Accounts/'+recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
       Account lst = AccountManager.getAccount();
      //Add assert to check the list of size
    }

    // Helper method
    static Id createTestRecord() {
        // Create test record
        Account accTest = new Account(Name='Test Record');
        insert accTest ;
        return accTest.Id;
    }          

}