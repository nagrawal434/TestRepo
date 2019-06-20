public class AggregateQueryController{
    public List<ModelClass> stuModelClass{get;set;}
    public AggregateQueryController(){
        List<aggregateResult> results = [select count(id) tot,Class__c cname 
                                        from 
                                        student__c group by Class__c];
        stuModelClass = new List<ModelClass>();
        for(aggregateResult result : results){
            ModelClass mocl = new ModelClass();
            String Nm = (String) result.get('cname');
            mocl.ClsName = [Select ClassName__c from Class__c Where id =: Nm];
            System.debug('$$$$' +mocl.ClsName);
            mocl.Counts = (integer) result.get('tot');
           
            stuModelClass.add(mocl);
        }
        
            System.debug('$$$$' + stuModelClass);
    }
    public class ModelClass{
        public Integer Counts{get;set;}
        public Class__c ClsName{get;set;}
        public ModelClass(){
            ClsName = new Class__c();
        }
    }
}