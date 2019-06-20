public class AccountHandler{
    public String accName;
    public AccountHandler(){
        accName = 'Neha New Acc';    
    }
    public static Account insertNewAccount(String accName){
        try {
            Account acct = new Account(name =accName);
            insert acct;
            return acct;
        } catch (DmlException e) {
              System.debug('A DML exception has occurred: ' +
                e.getMessage());
           return null;
}

        
    }
}