@isTest

public class SejalcontactDetail{
 
    static testMethod void testContact(){
        Contact con = new Contact(lastname = 'sejal gupta');
        
        list<contact> conlist= new list<contact>();
        conlist.add(con);
        insert conlist;
        system.debug('@@@list'+ conlist.size());
      
        Blob b = Blob.valueOf('Test Data');  
        Attachment a = new Attachment();  
        a.Name = 'Test';  
        a.parentId=con.id;
        a.Body = b;  
        insert a; 
        Document document = new Document(name='DefaultImagepic');
        document.AuthorId = UserInfo.getUserId();
        document.FolderId = UserInfo.getUserId(); 
        insert document;
        contactDetail obj = new contactDetail();
       
    }
        
        
}