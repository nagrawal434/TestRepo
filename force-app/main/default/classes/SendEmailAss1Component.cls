public class SendEmailAss1Component{
    public String stuId{get;set;}
    public List<Student__c> students;
    public List<Student__c> getStudent()
    {
        students = [Select  First_Name__c,Last_Name__c,email__c from Student__c where id =: stuId];
        System.Debug('##id'+stuId);
        return students;
    }
}