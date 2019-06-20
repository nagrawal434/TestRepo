public class ContactCheckboxController{
    public String ContactId{get;set;}
    public List<ContactModelNew> models1{get;set;}
    public List<Contact> editContactValue{get;set;}
    public List<Contact> contactlist{get;set;}
   
    
    
    public ContactCheckboxController()
    {
      models1= new List<ContactModelNew>();
      editContactValue = new List<Contact>();
                  for(Contact c: [Select id,firstname,lastname,email,phone from Contact]){
                          ContactModelNew obj = new ContactModelNew();
                          obj.cont= c;
                          obj.flag=false;
                          models1.add(obj);
                   }
    }
    public void editContact(){
       if(contactId !='')
       {
         for(ContactModelNew clsValue : models1)
            {
                if(clsValue.cont.id == contactId)
                {
                    editContactValue.add(clsValue.cont);
                }
            }  

        
       }     
   
    }
    public pageReference save(){
      ContactModelNew obj2 = new ContactModelNew();
      List<Contact> contactlist= new List<Contact>();
      for(ContactModelNew cm : models1){
           if(cm.flag){
               obj2.cont=cm.cont;
               obj2.flag=cm.flag;
               contactlist.add(obj2.cont);
           } 
        upsert contactlist;          
       } 
        return new pageReference('/apex/ContactCheckbox').setRedirect(True);
      }
      
    
    
    public class ContactModelNew{
        public Contact cont{get;set;}
        public boolean flag{get;set;}
   
        public ContactModelNew(){
            cont= new Contact();
        }
    }
}