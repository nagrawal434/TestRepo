@isTest
public class TestContactDetail{
    @isTest
    public static Void test(){      
        Document doc = new Document();
        doc.name = 'DefaultImage';
        doc.FolderId = '005280000010APHAA2';
        insert doc;
        Contact con = new Contact();
        con.firstname = 'ab';
        con.lastname = 'aa';
        con.phone = '123';
        con.email = 'a@gmail.com';
        insert con;
        Contact con1 = new Contact();
        con1.firstname = 'ab';
        con1.lastname = 'aa';
        con1.phone = '123';
        con1.email = 'b@gmail.com';
        insert con1; 
        Attachment att = new Attachment();
        att.name = 'as';
        att.body = blob.valueOf('as');
        att.parentId = con.id;
        insert att; 
        contactDetail obj = new contactDetail();  
    }    
     
}