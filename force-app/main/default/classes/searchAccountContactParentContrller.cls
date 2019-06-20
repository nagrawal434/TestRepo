public class searchAccountContactParentContrller {
	@AuraEnabled
    public static List<Contact> getContactList(Id accountRecId, string sortField, Boolean isAsc){
        system.debug('Account id in controller' +accountRecId);
        system.debug('Sort field in controller' +sortField);
        system.debug('ASC  in controller' +isAsc);
        string query = 'select id,firstname,lastname,phone,email from contact where accountId = :accountRecId order by ';
        if(sortField == 'firstname')
        	query = query + 'firstname';
        else if(sortField == 'lastname')
        	query = query + 'lastname';
        else if(sortField == 'email')
        	query = query + 'email';
        else if(sortField == 'phone')
        	query = query + 'phone';
        if(isAsc)
        	query = query + ' ASC';
        else
        	query = query + ' DESC';    
        List<Contact> contactList = Database.query(query);
        System.debug('####' +contactList);
        return contactList; 
    }
    @AuraEnabled
    public static List<Contact> inlineupdateContact(List<Contact> conList){
    	system.debug('&&&&' +conList);
        update conList;
        return conList;
    } 
}