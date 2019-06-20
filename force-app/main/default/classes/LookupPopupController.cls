public with sharing class LookupPopupController 
{

    public String query {get; set;}
    public List<Account> accounts {get; set;}
    public PageReference runQuery()
    {
       String nameMatch = '%'+ query +'%';
       accounts = [Select name,BillingStreet,BillingCity,BillingPostalCode from account Where name Like  : nameMatch];  
       return null;
    }
}