public class RelationDemoController{
    public List<Student__c> stuList{get;set;}
    public List<Class__c> clsList{get;set;}
    
    public RelationDemoController(){
        clsList = [select Name,(select First_Name__c from Students__r) from Class__c];
         stuList = [select Id,First_Name__c,Class__r.Name from Student__c Where  Class__r.Name =: 'H-0001' ];
         // stuList = [select Id,First_Name__c,Class__r.Name from Student__c ];
        
    }
}