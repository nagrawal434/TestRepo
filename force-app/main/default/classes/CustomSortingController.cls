public class CustomSortingController{
	@AuraEnabled
    public static list<Contact> fetchContacts(String sortField, boolean isAsc){
        String query = 'SELECT id,FirstName,LastName,Email,Phone FROM CONTACT';
        if(String.isNotBlank(sortField))
        	query = query + ' ORDER BY ' + sortField;
        if(isAsc)
            query = query + ' ASC';
        else
        	query = query + ' DESC';
        query = query + ' limit 20';
        System.debug('query +++++' +query);
        try{
        	List<Contact> conList = Database.query(query); 
        	return conList;
        }catch(Exception e){
        	System.debug('Exception ==========='  +e.getMessage());
            return null;
        }
    }       	
}