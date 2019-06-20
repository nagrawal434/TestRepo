public class EmailSendAss3Controller
{
    public String contactID{get;set;}
    public List<Contact> checkedContactValue{get;set;}
    public List<ModelContactClass> modelContact {get;set;}
    //public String emailid{get;set;}
    public String emailIdList {get;set;}
    public List<EmailTemplate> emailTemp {get;set;}
    public EmailTemplate selectET {get;set;}
    Set<String> emailSet{get;set;}
    public EmailSendAss3Controller()
    {
        emailTemp = new List<EmailTemplate>();
        emailTemp=[select id,name from EmailTemplate];
        checkedContactValue = new List<Contact>();
        modelContact = new List<ModelContactClass>();
        emailSet = new Set<String>();
        for(Contact cont : [select id,name,email,phone from contact])
        {
            ModelContactClass obj=new ModelContactClass();
            obj.con=cont;
            obj.rowid=modelContact.size()+1;
            obj.flag=false;
            modelContact.add(obj);
        }
    }
    public List<SelectOption> getemailTemplateList() {
        List<SelectOption> emailOption = new List<SelectOption>();
        emailOption.add(new SelectOption('','------------Select Email Template-------------'));
        for (EmailTemplate temp : emailTemp) 
        {
            emailOption.add(new SelectOption(temp.id,temp.name));
            
        }
        return emailOption;
    }
    public void sendTemplate()
    {
       ModelContactClass mv=new ModelContactClass();
       Set<String> st= new Set<String>();
       //Set<String> stid= new Set<String>();
       for(ModelContactClass m : modelContact)
       {
           if(m.flag)
           {
               mv.flag = m.flag;
               //stid.add(m.con.id);
               st.add(m.con.email);
           }
       }     
       system.debug('@@@' + st);
       
        selectET = new EmailTemplate();
       selectET = [select id ,name,folderid from EmailTemplate where id=:emailIdList];
       
       List<Messaging.SingleEmailMessage> emailSend = new List<Messaging.SingleEmailMessage>();
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       List<String> toAddressesList = new List<String>(st);
       //List<String> toTargetList = new List<String>(stid);
       mail.setToAddresses(toAddressesList);
       mail.setSubject('jdshjhcj');
       String body='<html><body> <i>Hello <br/> Good Morning </i> <br/><br/> ' + selectET + ' <br/><br/> Thank You</body></html>';
       mail.setHtmlBody(body);
       //mail.setTargetObjectId(toTargetList);
       emailSend.add(mail);
       if(!emailSend.isEmpty())        
       {
            // Messaging.sendEmail(emailSend);
       }              
    }
    public void fetchRecord()
    {
        if(contactID != '')
        {
            for(ModelContactClass clsValue : modelContact)
            {
                if(clsValue.con.id == contactID)
                {
                    if(clsValue.flag)
                        checkedContactValue.add(clsValue.con);
                }
            }
        }
        system.debug('$$$'+checkedContactValue);
    }
    public class ModelContactClass
    {
        public Contact con{get;set;}
        public Integer rowid{get;set;}
        public Boolean flag{get;set;}
      
    }
}