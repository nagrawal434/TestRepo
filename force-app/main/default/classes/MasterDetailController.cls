public class MasterDetailController{
    public List<fee__c> feeList{get;set;} 
    public MasterDetailController(ApexPages.StandardController sc){
        feeList= new List<fee__c>();
        String studentRec =  sc.getRecord().id;
        feeList= [select id,Amount__c,Date__c from fee__c where Course__r.stu__c = :studentRec];
    }
}