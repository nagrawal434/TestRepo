@isTest
    public class TestEmailPdf{
    @isTest
    public Static void Test(){
        Contact contact = new Contact();
        contact.lastName = 'Test Account';
        contact.DetailFee__c = 'Your fee is Demo';
   
        insert contact;
        PageReference pref = Page.EmailPdfPage;
        pref.getParameters().put('id',contact.id);
        Test.setCurrentPage(pref);
        EmailPdfController obj = new EmailPdfController();
        obj.modelList[0].Con.id = contact.id;
        obj.modelList[0].Chk = true;
        obj.modelList[0].Con.email = 'a@gmail.com'; 
        pref  = obj.sendMailPdf();
        obj.DisplayRecord();
        obj.next();
        obj.beginning();
        obj.previous();
        obj.end();
    }
    }