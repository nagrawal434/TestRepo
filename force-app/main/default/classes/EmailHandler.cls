global class EmailHandler implements Messaging.InboundEmailHandler {
      global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
             StudentEmail__c stu = new StudentEmail__c();
             List<Contact> contactList = new List<Contact>();
             stu.First_Name__c = email.fromname.substring(0,email.fromname.indexOf(' '));
             stu.Last_Name__c  = email.fromname.substring(email.fromname.indexOf(' '));
             stu.From__c = email.fromAddress;
             stu.body__c = email.htmlBody;
             stu.subject__c = email.subject;
             
             String  mailId= email.fromAddress;
             contactList = [select id,name,email from Contact where email =: mailId];
             if(contactList!=null){   
                 for(Contact c :contactList){
                          stu.IsExist__c = true;
                          stu.Contact__c = c.id;
                       }  
                  }
                 insert stu;     
             List<Attachment> atts = new List<Attachment>();
                 if(email.binaryAttachments != null && email.binaryAttachments.size()>0){
                     for(Messaging.InboundEmail.BinaryAttachment  a : email.binaryAttachments){
                             Attachment att = new Attachment();
                             att.ParentId = stu.id;
                             att.Name=  a.filename;
                             att.Body=  a.body;
                             atts.add(att); 
                     }

                 }
                 if(atts != null)
                 insert atts;
            return result;
      }
   }