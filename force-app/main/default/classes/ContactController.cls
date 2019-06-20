public with sharing class ContactController {
	@AuraEnabled
    public static List<Contact> getContacts(){
        List<Contact> contactList = [Select id,Name,Email,Phone FROM Contact];
        return contactList; 
    }
}