global with sharing class SomeBatchClass implements Database.Batchable<sObject> {

    List<sObject> objectList;

    public SomeBatchClass(List<sObject> l) {
        objectList = l;
    }

    global Iterable<sObject> start(Database.BatchableContext BC) {
        return new CustomIterable(objectList);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
         List<Account> accList = (List<Account>) scope;
         for(integer i=0;i<=100;i++)
            {
                Account ac=new Account();
                ac.Name='Nishi'+i;
                ac.AccountNumber='305246'+i;
                accList.add(ac);
            }
          insert accList;                                                        
    }

    global void finish(Database.BatchableContext BC) {
       
    }



    global class CustomIterable implements Iterable<sObject> {

        List<sObject> accList;

        public CustomIterable(List<sObject> l) {
            accList = new List<sObject>(); 
            accList = l;
        }

        global Iterator<sObject> Iterator() {
            return accList.iterator();
        }
    }
}