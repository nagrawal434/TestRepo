public class EmailSendingController{
    public Blob b{get;set;}
    public String sub{get;set;}
    public String address{get;set;}
    public String textbody{get;set;}
    public String file{get;set;}
    public Messaging.SingleEmailMessage email;
    public Messaging.EmailFileAttachment attachment;
    public List<Messaging.EmailFileAttachment> attachmentlist;
  
    public pageReference sendEmail(){ 
          Messaging.SingleEmailMessage  email = new  Messaging.SingleEmailMessage();
          List<Messaging.EmailFileAttachment> attachmentlist = new List<Messaging.EmailFileAttachment>(); 
          Messaging.EmailFileAttachment attachment =  new Messaging.EmailFileAttachment();
          email.setSubject(sub);  
          email.setToAddresses(new List<String>{address}); 
          email.setPlainTextBody(textbody);
          attachment.setBody(b);
          attachment.setFileName(file);
          attachmentlist.add(attachment);
          if(attachmentlist != null){
          email.setFileAttachments(attachmentlist);
          }
          Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email}); 
         
          return new pageReference('/apex/EmailSending').setRedirect(true);
        }
    
    
}