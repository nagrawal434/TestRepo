trigger DuplicateEmailCon on Contact (before insert,before update) {
    if(Trigger.isInsert){
        List<Contact> newContactList = new List<Contact>();
        DuplicateEmailConHelper.chkDuplicateInsertCon(Trigger.new);
    }else if(Trigger.isUpdate){
        DuplicateEmailConHelper.chkDuplicateUpdateCon(Trigger.old,Trigger.new,Trigger.oldMap);        
    }
    
}