global class MyBatchClass implements Database.Batchable<sobject>{
    //Construcor 
    global MyBatchClass(){
    }
    //start method to fetch record
    global Database.QueryLocator start(Database.BatchableContext Bc){
       system.debug('$$$$ StartMethod'); 
       return Database.getQueryLocator('Select id,website from Account');    
    }
    global void execute(Database.BatchableContext Bc, List<sObject> scope){
        List<Account> accList = (List<Account>) scope;
        for(Account a :accList){
            a.website='ibirdsservice.com';
        }
        if(accList.size()>0){
            update accList;
        }          
    }
    global void finish(Database.BatchableContext Bc){
    }

}