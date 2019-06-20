trigger CandidateTrigger on Condidate__c (after insert, after update) {

    List<Condidate__c> candidateList = new List<Condidate__c>();
    CandidateTriggerHelper.createAccount(Trigger.new);
}