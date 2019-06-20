public class mybatchapex1 implements database.Batchable<sobject>  
    {
        public database.querylocator start(database.BatchableContext bc)
        {
            return database.getquerylocator('select name, accountnumber from Account');
        }
        public void execute(database.BatchableContext bc, list<Account>zip)
        {
            System.debug('------------->');
            list<Account> z1=new list<Account>();
            for(integer i=0;i<=100;i++)
            {
                Account ac=new Account();
                ac.Name='Wasim'+i;
                ac.AccountNumber='305001'+i;
                z1.add(ac);
            }
            insert z1;
        }
        public void finish(database.BatchableContext bc)
        {
        }
    }