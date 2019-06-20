trigger TriggerOpportunity on Opportunity(after insert){
    List<Opportunity> OppList = new List<Opportunity>();
    if(trigger.isInsert){
        OpportunityTriggerHelper.creteNewCloneOpp(Trigger.new);   
    }

}