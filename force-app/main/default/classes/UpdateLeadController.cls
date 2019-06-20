public class UpdateLeadController {
		
 	@AuraEnabled
    public static Lead fetchLeadName1(Id leadId){
        System.debug('%%%%Lead Id' +leadId);
        Lead leadRec = [Select id,FirstName,Name from Lead where id = :leadId];
        return leadRec;
    }
    @AuraEnabled
    public static Lead updateLead(Lead updateLeadRec){
    	System.debug('After Update Lead Name' +updateLeadRec.Name);
        Upsert updateLeadRec;
        System.debug('After Update Lead Name2' +updateLeadRec.Name);
        return updateLeadRec;
    }
    
}