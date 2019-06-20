public class AccountUtils{
    public static List<Account> accountsByState(String state){
        List<Account> accList = new List<Account>();
        accList = [select id,name from Account where BillingState =: state];
        return accList;     
    }
}