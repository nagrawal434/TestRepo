public class CheckBoxEmailAssignmentPage{
    public List<Contact> allContacts{get;set;}
    public List<ContactModel> modelList{get;set;}
    public string to{get;set;}
    public List<string> addresses{get;set;} 
    public String fromAdd{set;get;}
    public String body{set;get;}
    public String subject{get;set;}
    public CheckBoxEmailAssignmentPage(){
        addresses = new List<String>();
        integer  i =0;
        allContacts = [SELECT id, FirstName,LastName, email from Contact];
        modelList = new List<ContactModel>();
        for(Contact con :allContacts){
        if(con.Email!=null){
            ContactModel cm = new ContactModel();
            cm.srno = ++i;
            cm.con = con;
            modelList.add(cm);
            }
        }
    }
    public void sendEmail(){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        addresses = to.split(',');
        email.setInReplyTo(fromAdd);
        email.setSubject(subject);
        email.setToAddresses(addresses);
        email.setPlainTextBody(body);
        emails.add(email);
        Messaging.sendEmail(emails);
    }  
    public class ContactModel{
        public Integer srno{get;set;} 
        public Contact con{set;get;}
        public String text{get;set;}    
        public ContactModel(){
            srno = 0;
            con = new Contact();
        }
    }
}