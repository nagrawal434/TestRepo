global class batchDelete implements Database.Batchable<sObject>{
  
global  batchDelete(){
     
   }
    global Database.QueryLocator start(Database.BatchableContext Bc){
        system.debug('$$$$ StartMethod2');
        return Database.getQueryLocator('select id from account where name Like : "Pooja Yadav"'); 
    }
    global void execute(Database.BatchableContext Bc, List<sObject> scope){
        delete scope;
        DataBase.emptyRecycleBin(scope);
    }   
    global void finish(Database.BatchableContext Bc){
    } 
}