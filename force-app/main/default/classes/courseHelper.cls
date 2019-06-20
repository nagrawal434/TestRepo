public class courseHelper{
    public static void onAfterUpdate(List<Course__C> courseList,Map<Id,Course__C> oldMap){
        List<Fee__c> toBeUpdatecourseList =new List<Fee__c>();
        List<Fee__c> feeList = new List<Fee__c>(); 
        Set<Id> courseIds = new Set<Id>();
        Map<Id,Course__c> courseMap = new Map<Id,Course__c>(); 
        for(Course__C courseRec : courseList){
            if(String.isNotBlank(courseRec.status__c)  
            && courseRec.status__c != oldMap.get(courseRec.id).status__c){
                courseIds.add(courseRec.id); 
                courseMap.put(courseRec.id,courseRec);               
            }         
        }
        if(courseIds.size() > 0 ){
            feeList = [SELECT id,Course__c from Fee__c where Course__c IN :courseIds];    
        } 
        if(feeList != null  && feeList.size() >0){
            for(Fee__c feeRec : feeList){
                if(courseMap.get(feeRec.Course__c) != null){
                    feeRec.Status__c = courseMap.get(feeRec.Course__c).Status__c;
                    toBeUpdatecourseList.add(feeRec);
                }           
            }
        }
        if(toBeUpdatecourseList != null && toBeUpdatecourseList.size() > 0){
            upsert toBeUpdatecourseList;
        }  
    }
}