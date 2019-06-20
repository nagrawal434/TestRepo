/*
    Author : Neha Agrawal
    Date : 1 April 2016
    Description : Copy Child Contacts Of Parent Account To New Copy Contact object
    Company : Ibirds Software Service Pvt. Ltd.

*/
public class CopyContactController{
    public String CurrentAccountId;
    public List<Contact> conList;
    public List<Copy_Contact__c> insertcopyConList;
    public List<Copy_Contact__c> previousCopyContact;
    public List<Copy_Contact__c> updateCopyContactList;
    public Map<String,Copy_Contact__c> previousCopyContactsMap;
    public CopyContactController(){
        conList = new List<Contact>();
        insertcopyConList = new List<Copy_Contact__c>();
        previousCopyContactsMap = new Map<String,Copy_Contact__c>();
        updateCopyContactList = new List<Copy_Contact__c>();
        CurrentAccountId = ApexPages.CurrentPage().getparameters().get('id');
        System.debug('********************' +CurrentAccountId);
        // Fetch Child Contacts of Current Account
        conList = [select id,firstname,lastname,name,email,phone,accountid  from contact where accountid =: CurrentAccountId];               
        // Fetch All Record Of Copy Contact Related To Current AccountId 
        previousCopyContact = [select id,firstname__c,lastname__c,email__c,phone__c,account__c from copy_contact__c Where account__c =: CurrentAccountId];
        for(copy_contact__c cp : previousCopyContact){
            previousCopyContactsMap.put(cp.email__c,cp);
        }
        for(Contact c: conList){
            if(!previousCopyContactsMap.containsKey(c.email)){
                // insert Non Duplicate Email Contact To Contact (Means Insert Only Contact Into Copy Contact If Email Of Child Contact do'nt match with Copy Contact Email Id) 
                Copy_Contact__c copyObj = new Copy_Contact__c();
                copyObj.firstName__c = c.firstname;
                copyObj.lastName__c = c.lastname;
                copyObj.email__c = c.email;
                copyObj.phone__c = c.phone;
                copyObj.account__c = c.accountid;
                insertcopyConList.add(copyObj);
            }else{
                // update Copy Contact
                Copy_Contact__c updateCopyContact = previousCopyContactsMap.get(c.email);
                updateCopyContact.firstName__c = c.firstname;
                updateCopyContact.lastName__c = c.lastname;
                updateCopyContact.email__c = c.email;
                updateCopyContact.phone__c = c.phone;
                updateCopyContactList.add(updateCopyContact);
            }     
        }     
    } 
    public pageReference copy(){
        
        if(insertcopyConList.size() > 0)
            insert insertcopyConList;
        if(previousCopyContact.size() > 0)
            upsert previousCopyContact;
        return new PageReference('/' +CurrentAccountId).setRedirect(True);     
     }       
}