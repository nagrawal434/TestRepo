public class LookupMainController 
{    
    public String accountId{get; set;}
    public List<Contact> contacts{get;set;}
    public LookupMainController(){
        contacts = new List<Contact>();    
    }
    public PageReference findContacts()
    {
        if (accountId != null)
            contacts=[select id,FirstName,LastName from Contact where AccountId =:accountId];
    return null;
    }
}