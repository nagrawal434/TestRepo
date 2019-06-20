public class ContactEditController{
    public List<Contact> contactList{get;set;}
    public List<ContactModel> models{get;set;}
    public List<ContactModel> obj{get;set;}
    public List<ContactModel> mv{get;set;}
    public Boolean mflag=false;
    public ContactEditController(){
          models= new List<ContactModel>();
          
           
          for(Contact clist :[Select id,firstname,lastname,email,phone from Contact]) 
           {      
                
                  ContactModel obj = new ContactModel();
                  obj.modelflag=mflag;
                  obj.conList =clist;
                  
                  models.add(obj);
            }
           
            
            
                  
     }
      public Class ContactModel
      {
        
        public Contact conList{get;set;}
        public Boolean modelflag{get;set;}
        public List<ContactModel> modifylist{get;set;}
        
        
          public ContactModel(){
           conList = new Contact();
           

        }
    }
  /* public pageReference save()
    {
            
            for(Contact m: models)
            {
            if(model.modelflag == true)
              {
                model.modifylist = m.conList;
                add(model);  
              }
            }
            
             upsert obj.conlist;
     
         return new pageReference('/' +obj.conlist.id).setRedirect(true);
    }*/

}