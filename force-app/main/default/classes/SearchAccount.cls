public class SearchAccount {
    @AuraEnabled
    public static List<Account> getAccountList(String searchKeyword){
    	List<Account> accList = new List<Account>();
        system.debug('SearchKey' +searchKeyword);
        if(string.isNotBlank(searchKeyword)){
        	String condition = '%' + searchKeyword + '%';
            accList = [SELECT Id,Name,Type,Industry FROM Account WHERE name LIKE : condition];	
            System.debug('Account List =====' +accList);
        }
        return accList;   
    }			
}