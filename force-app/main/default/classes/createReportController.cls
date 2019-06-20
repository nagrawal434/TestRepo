public class createReportController{
    public Report_Definition__c reportDefinition{get;set;}
    public List<ModelClassReportCriteria> ModelReportCriteriaList{get;set;}
    public Integer IndexReportCriteria{get;set;}
    public pod__c pod{get;set;}
    public createReportController(){
        reportDefinition = new Report_Definition__c();
        ModelReportCriteriaList = new List<ModelClassReportCriteria>();
        ModelClassReportCriteria reportCriteriaobj = new ModelClassReportCriteria();
        reportCriteriaobj.reportCriteria = new Report_Criteria__c();
        reportCriteriaobj.indexReportCreiteria = ModelReportCriteriaList.size();
        ModelReportCriteriaList.add(reportCriteriaobj);
        
    }
    public void addNewRow(){
        ModelClassReportCriteria reportCriteriaObj = new ModelClassReportCriteria();
        reportCriteriaObj.reportCriteria = new Report_Criteria__c();
        reportCriteriaObj.indexReportCreiteria = ModelReportCriteriaList.size();
        ModelReportCriteriaList.add(reportCriteriaObj);  
    }
    public void removeAccount(){
        ModelReportCriteriaList.remove(IndexReportCriteria);
        integer i=0;
        for(ModelClassReportCriteria m: ModelReportCriteriaList){
            m.indexReportCreiteria =i;
            i++;
        }    
    } 
    public void savePod(){
    }
    public class ModelClassReportCriteria{
        public Report_Criteria__c reportCriteria{get;set;}
        public Integer indexReportCreiteria{get;set;}        
        public ModelClassReportCriteria(){
            reportCriteria = new Report_Criteria__c();                 
        }
    }
}