/*
    Name : Neha Agrawal
    Date : 21/01/2016
    Author :
    Description : Job Application In Community

*/
public class JobAppComController{
  public List<ModelClass> modeljobList{get;set;}
    public string applyJobId{get;set;}
    public Job_Application__c   jobApplicatantObj{get;set;}
    public Job__c appliedJob{get;set;}
    public Id finalApplyJobId{get;set;}
    public Attachment resumeInsert{get;set;}
    private String jobId;
    private String CurrentjobId;  
    public JobAppComController(){
        applyJobId='';
        modeljobList = new List<ModelClass>();
        jobApplicatantObj = new Job_Application__c();
        resumeInsert = new Attachment();
        appliedJob = new Job__c();
        for(Job__c jb : [Select id,Post_Name__c,Status__c,No_Of_Post__c,Display_Date__c,Expire_Date__c,No_Of_Applicant__c from Job__c]){
            ModelClass obj = new ModelClass();
            obj.job = jb;
            modeljobList.add(obj);
        }
        jobId = ApexPages.currentPage().getParameters().get('fetchJobid');
        CurrentjobId  =  ApexPages.currentPage().getParameters().get('fetchJobid2'); 
        if(jobId != null){
            appliedJob  = [Select id,Post_Name__c,Description__c,Experience__c,Skills__c,Display_Date__c,Industry__c from Job__c Where Id =: jobId];
        }
    } 
    public pageReference applyJob(){
        System.debug('@@@'+applyJobId);
        
        if(userInfo.getUserType() == 'Guest'){
             return new pageReference('/login');
         }else{
            System.debug('####' +applyJobId);
             return new pageReference('/apex/JobAppComApplyPage?fetchJobid=' +applyJobId).setRedirect(true);
         }
    }
    public PageReference saveResume(){      
        String userID = userInfo.getUserID();
        List<User> obj = [select contactid from user where id = :userID];
        Job_Application__c jobApp = new Job_Application__c();
        jobApp.applicant__c = obj[0].contactid ;
        jobApp.job__c = CurrentjobId;
        jobApp.Apply_Date__c =Date.Today();
        insert jobApp;
        resumeInsert.parentid = jobApp.id;
        insert resumeInsert;  
        return new PageReference('/apex/JobApplicationComPage').setRedirect(true);       
    }    
    public pageReference applyFinal(){      
      return new pageReference('/apex/JobAppResumePage?fetchJobid2=' +finalApplyJobId).setRedirect(true);   
    } 
    public class ModelClass{
        public Job__c job{get;set;}
    }      
}