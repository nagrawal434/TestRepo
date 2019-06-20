public class EmailTemplateController{
        public List<selectOption> item{get;set;}
        public List<ContactModel> model{get;set;}
        public List<String> emailList{get;set;}
        public String selectTemplate{get;set;}
        public EmailTemplateController() {
                 item = new List<selectOption>();
                 //selectTemplate = new  List<selectOption>();
                 model = new List<ContactModel>();
                 emailList = new List<String>();
                for(EmailTemplate e :[Select id,name from EmailTemplate])
                    {
                        
                        item.add(new selectOption(e.id,e.name));       
                    }
                 for(Contact c : [select id,firstname,lastname,phone,email from contact]){
                     ContactModel obj = new ContactModel();   
                     obj.cont=c;
                     obj.flag=false;
                     model.add(obj);
             
                }
        }
        public void emaillistfunction(){
            for(ContactModel e1 : model) {
                    if(e1.flag) {
                        emailList.add(e1.cont.email);
                    }
            }
        }
        public pageReference sendEmail(){
             emaillistfunction();
             Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
             
             msg.setToAddresses(emailList);
             msg.setTemplateId(selectTemplate);
             for(ContactModel e1 : model) {
                    if(e1.flag) {
                        msg.setTargetObjectId(e1.cont.id);
                        break;
                    }
             }
            
             Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{msg});
             return new pageReference('/apex/EmailTemplate').setRedirect(true); 
       }
        
        public class ContactModel{
            public contact cont{get;set;}
            public Boolean flag{get;set;}
        
        }




}