public class CountStudentUsingMap{
    Map<String,Integer> studentcount;
    public CountStudentUsingMap(){
        studentcount = new Map<String,Integer>();
        for(student__c stu : [select id,First_name__c,Last_name__c,class__c from student__c]){
            integer count = 0;
            if(studentcount.containsKey(stu.class__c) && studentcount.get(stu.class__c)!= null){
                count = studentcount.get(stu.class__c);
            }
            studentcount.put(stu.class__c ,++count);
        }
        system.debug(studentcount);
    }
}