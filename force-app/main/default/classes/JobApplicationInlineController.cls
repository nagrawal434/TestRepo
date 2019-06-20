public class JobApplicationInlineController{
    private Job__c job{set;get;}
    public List<JobWrapper> jobList{set;get;}
    public Integer jobScore{set;get;}    
    public JobApplicationInlineController(ApexPages.StandardController stdController){
        //JobScore variable helps to determine total number of column on the basis of total score.
        jobScore = 0;
        
        jobList = new List<JobWrapper>();  
          
        this.job = (Job__c)stdController.getRecord();
        
        job = [select id,name,Skills__c,Domain__c,Experience__c from job__c where id =: job.id];
        
        jobScore = job.Experience__c!=null ? Integer.valueOf(job.Experience__c)  : 0;
        jobScore += job.Experience__c!=null ? job.Skills__c.split(';').size() : 0; 
        jobScore += job.domain__c!=null ? job.domain__c.split(';').size() : 0; 
        
        for(Job_Application__c ja : [select id,Experience__c,Applicant__r.name,Qualification__c,domain__c from Job_Application__c where job__c = : job.id]){
            jobList.add(new JobWrapper(ja,job,jobScore));
        }
    }
    public class JobWrapper{
        public String applicant{set;get;}
        public Integer score{set;get;}
        public Map<String,String> Qualifications{set;get;}
        public Integer Experience{set;get;}
        public Map<String,String> Domains{set;get;}
        public JobWrapper(Job_Application__c jobApplicant,Job__c job,Integer jobScore){
            score=0;
            applicant=jobApplicant.applicant__r.name;
            Qualifications = new Map<String,String>();  
            if(jobApplicant.Qualification__c!=null){                      
                for(String str: jobApplicant.Qualification__c.split(';')){
                    Qualifications.put(str,'extra');
                }
            }
            if(job.Skills__c!=null){
                for(String str: job.Skills__c.split(';')){
                    if(Qualifications.containsKey(str)==false){
                        Qualifications.put(str,'not_available'); 
                    }else{
                        score += 1;
                        Qualifications.put(str,'available'); 
                    }
                }
            }
            Domains = new Map<String,String>();
            if(jobApplicant.domain__c!=null){
                for(String str: jobApplicant.domain__c.split(';')){
                    Domains.put(str,'extra');
                }
            }
            if(job.Domain__c!=null){
                for(String str: job.Domain__c.split(';')){
                    if(Domains.containsKey(str)==false){
                        Domains.put(str,'not_available'); 
                    }else{
                        score += 1;
                        Domains.put(str,'available'); 
                    }
                } 
            }
            Experience = Integer.valueOf(jobApplicant.experience__c != null?jobApplicant.experience__c:0); 
            score += Experience;
            score = (score * 100 / jobScore) ;          
        }    
    }
    public Class JobModelClass{
        public Job_Application__c jobApp {get;set;}
        public JobModelClass(){
        
        }
    }
    
}