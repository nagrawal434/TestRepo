public class ContactController1 
{
   @AuraEnabled  
   public static List<Contact> FindAll()
   {
      return [select ID,Name,Phone from Contact LIMIT 20];
   }
   
    //Get contacts based on Contact Name
    @AuraEnabled
    public static List<Contact> FindByName(String searchKey_server)
   {
      String name='%'+searchKey_server+'%';
       return [select ID,Name,Phone from Contact where Name LIKE:name LIMIT 100];
   }
    
    //Get contacts based on Contact ID, single record
    @AuraEnabled
    public static Contact FindByID(String conID)
   {
      return [select ID,Name,Account.Name,Phone from Contact where ID=:conID LIMIT 100];
   }
}