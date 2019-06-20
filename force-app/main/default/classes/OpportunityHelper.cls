public class OpportunityHelper{
    public static List<Opportunity> toBeUpdatedOppList = new List<Opportunity>();
    public static void onInsert(List<Opportunity> OpportunityList){
        for(Opportunity opp : OpportunityList){
            if(opp.Type == 'New Customer'){
                if(opp.Start_Date__c != null && opp.Contract_Month__c != null){
                    opp.closeDate = opp.Start_Date__c.addMonths(Integer.valueOf(opp.Contract_Month__c)); 
                    toBeUpdatedOppList.add(opp);
                }        
            }
        }
        if(toBeUpdatedOppList != null && toBeUpdatedOppList.size() >0 ){
            upsert toBeUpdatedOppList; 
        }
    }
    public static void onUpdate(List<Opportunity> OpportunityList,Map<id,opportunity> oppMap){
    
    }
}