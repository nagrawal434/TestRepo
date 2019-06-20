/*
    Author :  Neha Agrawal
    Date : 1 April 2016
    Description : Helper Class Of DuplicateEmailCon Trigger On Contact
    Company : Ibirds Software Services Pvt. Ltd.
*/


public class DuplicateEmailConHelper{
    public static void chkDuplicateInsertCon(List<Contact> conList){
        Map<String,Contact> emailContactMap = new Map<String,Contact>();
        List<Contact> allContactList = new List<Contact>();
        List<Contact> DuplicateContactList = new List<Contact>();
        Set<String> emailSet = new Set<String>();
        for(Contact c : conList){
            emailSet.add(c.email);    
        }
        allContactList = [select id,firstname,lastname,email,phone,MatchContact__c from contact Where Email IN: emailSet];
        for(Contact c : allContactList){
            emailContactMap.put(c.email,c);            
        }
        for(Contact con : conList){
            if(emailContactMap.containsKey(con.email) && con.email != null){
                con.email.addError('Email Not To be Duplicate');  
            }
        }
    }
    public static void chkDuplicateUpdateCon(List<Contact> tobeUpdatedRecord,List<Contact> newUpdateRecord,Map<id,Contact> oldMap){
        Map<String,Contact> oldRecordMap = new Map<String,Contact>();
        Set<String> newUpdateRecordEmailSet =new Set<String>();
        List<Contact> allContactList = new List<Contact>(); 
        for(Contact c : newUpdateRecord){
            newUpdateRecordEmailSet.add(c.email);
        }
        allContactList = [select id,firstname,lastname,email,phone,MatchContact__c from contact Where Email IN: newUpdateRecordEmailSet];
        for(Contact c : allContactList){
            oldRecordMap.put(c.email,c);
        }
        for(Contact c : newUpdateRecord){
            if(c.email != oldMap.get(c.id).email && c.email != null ){
                if(oldRecordMap.containsKey(c.email)){
                    c.email.addError('Email Already Exist');
                }                        
            }                                    
        }                 
    }
}