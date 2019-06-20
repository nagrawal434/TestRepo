public class RoomDetailController{
    public Room__c recordDetails{get;set;}
    public String recordId{get;set;}
    public RoomDetailController(){
       recordDetails = new Room__c();
       recordId = ApexPages.currentPage().getParameters().get('Id');
       recordDetails = [Select id from Room__c Where id =: recordId];
    }
    public pagereference Detail(){
       
       return new pagereference('/' +recordDetails.id);
    }
}