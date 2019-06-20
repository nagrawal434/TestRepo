trigger EmailContactInsert on Contact(before update,before insert) {
    
        public Map<String,Contact> EmailMap;
        public List<Contact> emailsid; 
        EmailMap = new Map<String,Contact>();
        emailsid = [select id,firstname,lastname,email from Contact];
        for(Contact c : emailsid)
        {
          EmailMap.put(c.email,c);
        } 
    if(Trigger.isInsert)
    {
         for(Contact c : Trigger.new){
               if(EmailMap.containsKey(c.email) && c.email != null)
                   {
                      c.email.addError('Email Already Exist');   
                   }
            
         }
     }
    if(Trigger.isUpdate)
     {
        for(Contact c : Trigger.new){
               if(c.email !=  Trigger.OldMap.get(c.id).email){
                   if(EmailMap.containsKey(c.email) && c.email != null )
                       {
                          c.email.addError('Email Already Exist');   
                       }
               }    
          } 
     }
}