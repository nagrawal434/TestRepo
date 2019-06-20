global class DemoBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('&&&& In Start Method');
        String query = 'SELECT Id,Name FROM Account';
        //return Database.getQueryLocator(query);
        return null;
    }
   
    global void execute(Database.BatchableContext BC, List<Account> scope) {
         System.debug('&&&& In Execute Method');
         /*for(Account a : scope)
         {
             a.Name = a.Name + 'Updated';            
         }
         update scope;
         */
    }   
    
    global void finish(Database.BatchableContext BC) {
        System.debug('&&&& In Finish Method');
    }
}