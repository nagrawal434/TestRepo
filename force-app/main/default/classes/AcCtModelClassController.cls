public class AcCtModelClassController{
    public  list<account> accounts{get;set;}
    public  list<ModelClass> models{get;set;}
    public  list<contact> contact{get;set;}
        public AcCtModelClassController(){
                          models= new list<ModelClass>();
                          accounts= new list<account>();   
                          accounts = [Select name,(Select firstname,lastname,email,phone from contacts) from account];
      
          for(account acc : accounts){
              ModelClass obj= new ModelClass();
              obj.acctname = acc.name;
              obj.conname = acc.contacts;
              models.add(obj);
              }
              
         }
         public class ModelClass{
             public String acctname{get;set;}
             public list<contact> conname{get;set;}
       
             public ModelClass(){
                 
                 conname = new list<contact>();
             }
        }
            

}