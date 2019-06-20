/* Name : Neha Agrawal
   Author : 
   Date : 1/2/2015
   Description : Job Applicant List 
*/


public class jobApplicantListController{
    Public String jobId;
    public job__c jobDetail;
    public List<ModelClass> modelList{get;set;}
    public Map<List<String>,String> skillsMap{get;set;}
    public String ContactId{get;set;}
    public List<String> jobApplicantList; 
    public jobApplicantListController(){
        jobId = ApexPages.currentPage().getParameters().get('id');
        modelList = new List<ModelClass>();
        skillsMap = new Map<List<String>,String>();  
        System.debug('@@@@' +jobId);
        jobDetail = [Select id,Skills__c,Experience__c from job__c Where id =: jobId];
        System.debug('#####' +jobDetail.skills__c);
        if(jobDetail.skills__c!=null){                      
            List<String> str = jobDetail.skills__c.split(';');
            skillsMap.put(str,'skillchk');        
                
        }
        System.debug('$$$' +skillsMap);
        for(Job_Application__c jb : [select id,Qualification__c,Applicant__c from Job_Application__c Where job__r.id =: jobId]){
            ModelClass obj = new ModelClass();
            obj.jobApplication = jb;
            obj.Chk = false; 
            modelList.add(obj);
        }
                         
    }
    public void sendMail(){
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        for(ModelClass m : modelList){
            if(m.chk == true){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setTargetObjectId(m.jobApplication.Applicant__c);
                mail.setTemplateId('00X280000017GycEAE');
                mailList.add(mail);
            } 
            Messaging.sendEmail(mailList);
        }
    }    
    public Class ModelClass{
        public Job_Application__c jobApplication{get;set;}
        public Boolean Chk{get;set;}        
        public ModelClass(){
        } 
    }
}