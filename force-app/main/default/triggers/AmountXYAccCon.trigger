trigger AmountXYAccCon on Contact(after insert,after update){
    Set<String> ids = new Set<String>();
   
    Map<String,Decimal> Xmap =  new Map<String,Decimal>() ;
    Map<String,Decimal> Ymap = new Map<String,Decimal>();
    if(Trigger.isInsert || Trigger.isUpdate)
    {
    for(Contact c : Trigger.new){
            if(c.accountid !=null){
                 ids.add(c.accountid);         
            }        
     } 
        for(Contact c: [Select accountid,id,Amount_X__c,Amount_Y__c,Type__c from Contact Where AccountId IN : ids]){
                Decimal xc;
                Decimal yc;
                if(c.Type__c == 'Positive' && c.Amount_X__c != null){
                       xc = Xmap.get(c.accountid);
                       if(xc == null){
                             xc = 0;
                       }      
                
                   xc += c.Amount_X__c;
                   Xmap.put(c.accountid,c.Amount_X__c);
                 }
                if(c.Type__c == 'Negative' && c.Amount_Y__c != null){
                             yc = Ymap.get(c.accountid);
                             if(yc == null){
                                 yc = 0;    
                             }
                    yc += c.Amount_Y__c;
                    Ymap.put(c.accountid,c.Amount_Y__c);
                    }
              }
              List<account> accToUpdate = new List<Account>();
             for(Account a : [Select id,name,Rollup_Amount_X__c,Rollup_Amount_Y__c,Rollup_Amount__c from Account where id IN : ids])
              {
                   decimal total = 0;
                   System.debug('###> '+Xmap.get(a.id));
                   if(Xmap.get(a.id) != null)
                   {
                       a.Rollup_Amount_X__c = Xmap.get(a.id);
                       total +=  Xmap.get(a.id);
                       
                   }
                   if(Ymap.get(a.id) != null)
                   {
                       a.Rollup_Amount_Y__c = Ymap.get(a.id);
                       total +=  Ymap.get(a.id);
                   
                   }
                   a.Rollup_Amount__c = total;  
                   accToUpdate.add(a);
            }
            if(accToupdate.size()>0){
                update accToUpdate;
            }
             
  }     
}