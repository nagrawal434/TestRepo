public class createNoteAttachController{
    public Note__c note{get;set;}
    public Attachment AttchFile{get;set;}
    public Task task{get;set;}
    public Boolean isChkManager{get;set;}
    public Boolean isChkMyself{get;set;}
    public Boolean isChkuser{get;set;}
    public List<SelectOption> alluserlist{get;set;}
    public List<selectOption> selectedUser{get;set;}
    public Boolean multiListDisplay{get;set;}
    public createNoteAttachController(){
        note = new Note__c();
        AttchFile = new Attachment();
        task = new task();
        multiListDisplay = false;
        selectedUser = new List<selectOption>(); 
    }
    public pageReference saveRecord(){
        insert note; 
        AttchFile.parentId = note.id;
        insert AttchFile;
        profile profleId = [select id from profile Where name = 'system administrator'];
        user selectuser = [select id,contactId from user Where profileId =: profleId.id];
        //String currentUserId = UserInfo.getUserId();
        System.debug('#####' +selectedUser);
        task.WhatId = note.contact__r.accountId;
        if(isChkManager == true){
            task.WhoId = selectuser.contactId;
        }
        if(isChkMyself == true){
            task.WhoId = UserInfo.getUserId();  
        }
        if(isChkuser == true){
            for(selectOption op : selectedUser){
                task.whoId = op.getValue();
            }             
         }
        task.Subject = 'note.name__c';
        task.priority= 'high';
        task.status = 'Not Started';
        task.description = 'New  Work';
        insert task;
        return new pageReference('/apex/createNoteAttachPage').setRedirect(true);            
    } 
    public void cancelRecord(){
    } 
    public void copyNote(){
    } 
    public void myMethod(){
        multiListDisplay = true;
        system.debug('AAAAA' +isChkuser);
        System.debug('FFFF' +selectedUser);
        alluserlist = new List<SelectOption>();
        List<selectOption> options = new List<selectOption>(); 
        for(user usr : [select id,name from user]){
                options.add(new selectOption(usr.id,usr.name));
        } 
        alluserlist = options;      
    }
}