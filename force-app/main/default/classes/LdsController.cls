public with sharing class LdsController {
 
    public List<Contact> contactList{get;set;}
    public List<Account> accountList{get;set;}
 
    public LdsController()
    {
        contactList = new List<Contact>();
        contactList = [select name,firstname,lastname,accountid from Contact ];    
        accountList = [select id,name from account];    
    }
     
    public void actionfunction()
    {
        contactList = [select id,name from contact where accountId = :   ApexPages.currentPage().getParameters().get('accountId')];
 
    }
}