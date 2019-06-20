public class StudentListEmailTemplate{
    public List<Student__c> stulist{get;set;}
    public StudentListEmailTemplate(){
        stuList = new List<Student__c>();
        stuList=[select First_Name__c,Last_Name__c,email__c from Student__c];
   }
}