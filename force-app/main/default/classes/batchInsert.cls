global class batchInsert implements Database.Batchable<sObject>{
   global batchInsert(){
   }
    global Database.QueryLocator start(Database.BatchableContext Bc){
        system.debug('$$$$ StartMethod2');
        return Database.getQueryLocator('select name,accountnumber from Account limit 2'); 
    
    }
    global void execute(Database.BatchableContext Bc, List<sObject> scope){
        List<Account> accList = (List<Account>)scope;
        List<Account> accountList = new List<Account>();
             Account ac = new Account();
             ac.name = 'Manisha ';
             ac.accountnumber = '12234';
             accountList.add(ac);
        if(accList.Size()>0){
           insert accountList;
        }
    }   
    global void finish(Database.BatchableContext Bc){
    } 
}