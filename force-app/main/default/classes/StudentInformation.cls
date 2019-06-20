public class StudentInformation{
     public String stuId{get;set;}
     public Student__c stu{get;set;}
     public StudentInformation(){
         stuId=ApexPages.currentPage().getParameters().get('Id');
         stu= [select email__c from Student__c where id =: stuId];
    
     }  
     public PageReference Send(){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE Name = 'VisualforceTemplate2'];
        email.setTemplateId(et.Id);
        email.setToAddresses(new List<String>{stu.email__c});
        email.setTargetObjectId([select id from Contact limit 1].id);
        email.setWhatId(stuId);
        email.setSaveAsActivity(false);
        emails.add(email);
        
        Messaging.SendEmail(emails);
        return null;
}

}