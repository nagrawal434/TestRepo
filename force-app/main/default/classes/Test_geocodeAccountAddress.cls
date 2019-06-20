@isTest
public class Test_geocodeAccountAddress{
    @isTest
    private static void test(){
        Account acc = new account();
        acc.name = 'test';
        acc.BillingStreet = 'Shashtri Nagar';
        acc.BillingState = 'Rajasthan';
        acc.BillingCity = 'Ajmer';
        acc.BillingCountry = 'India';
        acc.BillingPostalCode = '305001';
        
        insert acc;
        
        
    }
}