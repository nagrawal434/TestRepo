public class UpdateLeadUsingModel {
	@AuraEnabled
    public static Lead fetchLeadDetail(Id leadId){
        lead leadRecord = [Select id,MobilePhone From Lead Where id = :leadId];
        return leadRecord;
    }
}