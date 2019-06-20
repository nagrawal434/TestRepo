trigger CaseTrigger on Case (Before Update){
    List<Case> CaseList = new List<Case>();
    if(Trigger.isUpdate){
        HireProcessTriggerHelper.BeforeCaseUpdate(Trigger.new);
    }
}