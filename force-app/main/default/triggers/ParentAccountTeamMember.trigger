trigger ParentAccountTeamMember on Account (After insert,after update,after undelete){
    Set<Id> accontIds = new Set<Id>();
    Map<id,Id> mapAcc= new Map<id,Id>();
    List<Account> ToBeUpdateList= new List<Account>();
    // Trigger On After Insert
       
    if(trigger.isAfter){      
        // Trigger On Insert Account
        if(trigger.isInsert){
            ParentAccountTeamMemberHelper.insertAccountTeam(Trigger.new);            
        }
    
    }
    if(Trigger.isupdate){
        for(Account a: Trigger.new)
        {
            if(a.ownerId != trigger.OldMap.get(a.id).OwnerId){
                ToBeUpdateList.add(a);         
            }
        } 
        if(ToBeUpdateList.size() >0){
            ParentAccountTeamMemberHelper.insertAccountTeam(ToBeUpdateList);    
        }  
    }

}