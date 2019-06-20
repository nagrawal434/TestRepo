@isTest
public class CopyContactControllerTest{
    static testMethod Void testMethod1(){
        List<Contact> cList = new List<Contact>();
        List<Copy_Contact__c> previousCopyContact = new List<Copy_Contact__c>();
        List<Copy_Contact__c> insertcopyConList = new List<Copy_Contact__c>(); 
        Account acc = new Account(name= 'TestAccount');
        insert acc;
        ApexPages.currentPage().getParameters().put('id',acc.id);
        Contact con1 = new Contact(firstname = 'confirst1', lastname= 'conLast1',email = 'con1@gmail.com',phone = '1111',accountId = acc.Id);
        Contact con2 = new Contact(firstname = 'confirst2', lastname = 'conLast2',email = 'con2@gmail.com',phone = '222',accountId = acc.Id);
        cList.add(con1);
        cList.add(con2);
        insert cList;
        Copy_Contact__c copyCon1 = new Copy_Contact__c(firstname__c = 'copyConfirst1', lastname__c = 'copyConLast1', email__c = 'copyCon1@gmail.com', phone__c = '3333',account__c = acc.Id);
        Copy_Contact__c copyCon2 = new Copy_Contact__c(firstname__c = 'copyConfirst2',lastname__c = 'copyConLast2', email__c = 'con1@gmail.com',phone__c ='2323', account__c = acc.Id);
        previousCopyContact.add(copyCon1);
        previousCopyContact.add(copyCon2);
        insert previousCopyContact; 
        CopyContactController obj = new CopyContactController();
        obj.copy(); 
    }
    
}