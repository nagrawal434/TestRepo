trigger ContactAccountScore on Contact(after insert,after update,after delete,after undelete){
   
    Set<Id> AccountIds= new Set<Id>(); 
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isunDelete){
            for(Contact con: Trigger.new){
                if(con.Amount_X__c !=null || con.Amount_Y__c != null){
                    if(con.accountId != null)
                        AccountIds.add(con.accountId);
                }        
            }
            if(AccountIds.size() >0)
                ContactAccountStoreHelper.insertUpdateAccountScore(AccountIds);
        }
        if(trigger.isUpdate){
            for(Contact con: Trigger.new){
                if(con.Amount_X__c !=null || con.Amount_Y__c != null){
                    if(con.Amount_X__c != trigger.oldMap.get(con.id).Amount_X__c || con.Amount_Y__c != trigger.oldMap.get(con.id).Amount_Y__c){              
                        AccountIds.add(con.accountId);    
                    }
                    if(con.accountId != trigger.oldMap.get(con.id).accountId){
                        AccountIds.add(con.accountId);
                        AccountIds.add(Trigger.oldMap.get(con.id).accountId);        
                    }
                }
            }
            if(AccountIds.size() >0){
                ContactAccountStoreHelper.insertUpdateAccountScore(AccountIds);    
            }                                   
        }
        if(trigger.isDelete){
            for(Contact con: Trigger.old){
                if( con.accountId != null)
                    AccountIds.add(con.accountId);    
            }
            if(AccountIds.size() >0){
                ContactAccountStoreHelper.insertUpdateAccountScore(AccountIds);    
            }
        }     
    }
}