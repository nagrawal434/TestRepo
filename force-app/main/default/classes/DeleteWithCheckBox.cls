public class DeleteWithCheckBox {
	@AuraEnabled
    public static List<Contact> fetchContacts(){
        List<Contact> conlist = [SELECT id,FirstName,LastName,Email,Phone From Contact limit 2];
        return conlist; 
    }
    @AuraEnabled
    public static List<String> deleteContactList(List<String> recordsId){
        List<String> errorMsg = new List<String>();
        List<Contact> deletedContacts = [SELECT id FROM Contact WHERE id IN : recordsId];
        Database.DeleteResult[] DR_Dels = Database.delete(deletedContacts, false);
        for(Database.DeleteResult result : DR_Dels){
            if(result.isSuccess()){
                system.debug('Sucessfully deleted');
            }else{
            	errorMsg.add('');	
                for (Database.Error err: result.getErrors()) {
                    // add Error message to oErrorMsg list and return the list
                    errorMsg.add(err.getStatusCode() + ': ' + err.getMessage());
                }                
            }
        }
        return errorMsg;        
    }
}