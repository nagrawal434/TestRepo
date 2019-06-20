public with sharing class ParentAccountTeamMemberHelper{
    public static List<Account> accountParentList= new List<Account>();
    public static List<AccountTeamMember> accTeamMemberList= new List<AccountTeamMember>();
    public static Map<Id,Account> accountMap= new Map<Id,Account>(); 
    public static Set<Id> parentSet= new Set<Id>();
      
    public static void insertAccountTeam(List<account> newAccList){
        /*for(Account acc: newAccList){
            if(acc.parentId != null)
            parentSet.add(acc.parentId);        
        } 
        
        accountParentList= [Select id,OwnerId from Account Where Id IN :parentSet]; 
        
        for(Account accPar: accountParentList){
            accountMap.put(accPar.id,accPar);    
        }              
        for(Account acc : newAccList){            
            AccountTeamMember Teammemberad =new AccountTeamMember();
            Teammemberad.AccountId= acc.id;
            Teammemberad.UserId= accountMap.get(acc.ParentId).OwnerId;
            Teammemberad.TeamMemberRole = 'Account Modifier';
            accTeamMemberList.add(Teammemberad);
        }        
        if(accTeamMemberList.size() >0){
            insert accTeamMemberList; 
        } */               
    }
    public static void updateAccountTeam(List<Account> newAccountToUpdateList){
        /*Set<Id> parentIds= new Set<Id>();
        set<Id> accountIds = new Set<Id>();
        for(Account a: newAccountToUpdateList){
            parentIds.add(a.id);                         
        }
        List<Account> accList= [select id from account where ParentId IN :parentIds];
        for(Account acc: accList){
            accountIds.add(acc.id);
        }
        list<AccountTeamMember>  temMemList=  [select id from accountTeamMember where accountId IN :accountIds];
        
       */ 
    }    
          
}