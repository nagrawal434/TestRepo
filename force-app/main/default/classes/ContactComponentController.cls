public class ContactComponentController{
    public List<Contact> clist{get;set;}
    
   
    public ContactComponentController(){
          clist = new List<Contact>();
          clist  = [Select firstname,lastname,email,phone from Contact];
               
        }
    
    }