public with sharing class remoteContactNotificationController{

    @RemoteAction
    public static contact contactDetail(String contactId){
        return[select id,firstName,LastName,Email,Phone,account.name,BirthDate from contact where id =: contactId];
    }
}