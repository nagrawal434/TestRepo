trigger CampaignMemberTrigger on CampaignMember(after insert,after update,after delete) {
    CampaignMemberHandler handler = new CampaignMemberHandler();
    //call helper class method while after insert
    if(Trigger.isAfter &&( Trigger.isInsert || Trigger.isUpdate))
        handler.onAfterInsert(trigger.new);
    if(Trigger.isAfter && Trigger.isDelete){
        handler.onDeleteCampaignMember(trigger.old);        
    }
}