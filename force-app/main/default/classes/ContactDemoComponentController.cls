public class ContactDemoComponentController{
    public List<Contact> conlist{get;set;}
    
   
    public ContactDemoComponentController(){
          conlist = new List<Contact>();
          conlist  = [Select firstname,lastname,email,phone from Contact];
               
        }
      
   
    
    }