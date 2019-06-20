global class BatchClassInsertAss implements Database.Batchable<sObject>{
    
     global BatchClassInsertAss(){
                // Batch Constructor
     }
     
     // Start Method
     global Database.QueryLocator start(Database.BatchableContext BC){
         system.debug('---Start Methode');

         return Database.getQueryLocator('select id, website from account limit 2');
     }
    
     // Execute Logic
     global void execute(Database.BatchableContext BC, List<sObject>scope){
         // Logic to be Executed batch wise     
         List<account>accInsert = new List<account>();
         List<account> actList = (List<Account>)scope; 
         for(account a:actList){
             a.website = 'ibirdsservices.com';
             account ac = new account();
             ac.name = 'newBatchClass';
             accInsert.add(ac);
         }
         if(actList.size()>0) {
             insert accInsert;
         }
     }
   
     global void finish(Database.BatchableContext BC){
         // Logic to be Executed at finish
     }
 }