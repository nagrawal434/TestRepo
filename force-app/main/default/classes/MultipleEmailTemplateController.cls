public class MultipleEmailTemplateController{
 
    public List<TemplateModel> StudentListModel{get;set;}
    public String detail{get;set;}
    public List<Student__c> fetchStudentList{get;set;}
    public MultipleEmailTemplateController()
    {
        //VisualforceTemplateass1
        StudentListModel = new List<TemplateModel>();
        fetchStudentList = new List<Student__c>();
        for(Student__c sc : [Select First_Name__c,Last_Name__c,email__c from Student__c])
        {
            TemplateModel obj = new TemplateModel();
            obj.stuListModel= sc;
            obj.flag=false;
            StudentListModel.add(obj);
        }
   
    }
    public void mailRecord()
    {
        if(detail != ''){
            for(TemplateModel tm : StudentListModel)
            {
                if(tm.flag)
                {
                    if(tm.stuListModel.id==detail)
                    {
                        fetchStudentList.add(tm.stuListModel);
                    }
                }
            }
            system.debug('@@@' + fetchStudentList);
        }
        
    }
    public class TemplateModel{
        public Student__c stuListModel{get;set;}
        public Boolean flag{get;set;}
        public TemplateModel()
       {
            stuListModel= new Student__c();   
       }
    }
      public void send(){
        for(Student__c st : fetchStudentList)
        {
            List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE Name = 'VisualforceTemplateass1'];
            email.setTemplateId(et.Id);
            email.setToAddresses(new List<String>{st.Email__c});
            email.setTargetObjectId([select id from Contact limit 1].id);
            email.setWhatId(st.id);
            email.setSaveAsActivity(false);
            emails.add(email);
            Messaging.SendEmail(emails);
        }            
   }
  
}