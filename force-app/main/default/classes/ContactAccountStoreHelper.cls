public with sharing class ContactAccountStoreHelper{
    public Static List<Account> accountList= new List<Account>();
    public static Map<Id,Account> mapAccount= new Map<Id,Account>();
      
    public static void insertUpdateAccountScore(Set<Id> AccountIds){
        List<AggregateResult> aggregateResultofAmount= [Select SUM(Amount_X__c) sumX, SUM(Amount_Y__c) sumY, accountId accId from CONTACT Where accountId IN: AccountIds GROUP BY accountId]; 
        
        for(AggregateResult argResult: aggregateResultofAmount){
        Account acc = new Account();
            acc.id= string.valueOf(argResult.get('accId')); 
            acc.Rollup_Amount_X__c= decimal.valueOf(string.valueOf(argResult.get('sumX')));
            acc.Rollup_Amount_Y__c= decimal.valueOf(string.valueOf(argResult.get('sumY')));
            mapAccount.put(acc.id,acc);
        }
        if(mapAccount != null){
            update mapAccount.values();
        }
        
    } 
}