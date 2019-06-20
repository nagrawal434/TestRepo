/*
    Name : Neha Agrawal
    Date : 19-January-2016
    Author :
    Description : 'Job Application'
*/
Public Class JobApplicationTriggerHelper{
    public static void sendEmail(List<Job_Application__c> jobApplicationList){
        Map<id,Job_Application__c> revApplicantMap = new  Map<id,Job_Application__c>();
        Map<Id,Attachment> attchMap = new Map<Id,Attachment>(); 
        List<Job_Application__c> rewJobList = new List<Job_Application__c>(); 
        List<Attachment> attList = new  List<Attachment>(); 
        Set<Id> parentIdSet = new Set<Id>();
        for(Job_Application__c jb : jobApplicationList){
            revApplicantMap.put(jb.id,jb);
            parentIdSet.add(jb.id);            
        }
        attList = [Select id,name,body,parentId  From Attachment Where parentId IN : parentIdSet];
        for(Attachment attObj : attList){
            attchMap.put(attObj.parentId,attObj);    
        }
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>(); 
        for(Id obj : revApplicantMap.keySet()){
            List<Messaging.EmailFileAttachment> sendAttList = new List<Messaging.EmailFileAttachment>(); 
            if(revApplicantMap.get(obj).ReadOnlyStatus__c  != 'Submitted' && revApplicantMap.get(obj).ReadOnlyStatus__c  != 'Appointed' && revApplicantMap.get(obj).ReadOnlyStatus__c  != ' Rejected'){  
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setWhatId(obj);
                System.debug('&&&&' +revApplicantMap.get(obj).ReadOnlyStatus__c);            
                if(revApplicantMap.get(obj).ReadOnlyStatus__c == 'Internal Reviewer'){
                    email.setSubject('To Review');
                    String messageBody = 'You Have to Review The Applicant Resume';
                    email.setHtmlBody(messageBody);
                    System.debug('@@@');
                    email.setTargetObjectId(revApplicantMap.get(obj).ReviewerName__c);
                } 
                System.debug('!!!!!&&&&' +revApplicantMap.get(obj).ReadOnlyStatus__c);
                if(revApplicantMap.get(obj).ReadOnlyStatus__c  == 'Interview'){
                    email.setSubject('To Interview');
                    String messageBody = 'You Have to Take Interview Applicant';
                    email.setHtmlBody(messageBody);
                    System.debug('****');
                    email.setTargetObjectId(revApplicantMap.get(obj).InterviewerName__c);
                } 
                System.debug('$$$$$&&&&' +revApplicantMap.get(obj).ReadOnlyStatus__c);
                if(revApplicantMap.get(obj).ReadOnlyStatus__c  == 'HR Round'){
                    email.setSubject('To HR');
                    String messageBody = 'You Have to take HR Round';
                    email.setHtmlBody(messageBody);
                    System.debug('^^^^');
                    email.setTargetObjectId(revApplicantMap.get(obj).HRName__c);
                }
                emailList.add(email);                 
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName('ApplicantResume.pdf');
                for(Id idParentKey  : attchMap.keySet()){
                    if(revApplicantMap.containsKey(idParentKey)){
                         efa.setBody(attchMap.get(idParentKey).body);
                         sendAttList.add(efa);       
                    }
                } 
                if(sendAttList.size() > 0)
                    email.setFileAttachments(sendAttList);    
           }
       }     
          Messaging.sendEmail(emailList);
                 
    } 
}