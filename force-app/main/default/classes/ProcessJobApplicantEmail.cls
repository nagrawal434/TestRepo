global class ProcessJobApplicantEmail implements Messaging.InboundEmailHandler {
    global List<Attachment> attachList;
    global Blob fileBody;
    global String fileString;
    global String[] csvFileLines;
    global List<Contact> conList;
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope) {
    csvFileLines = new String[]{};
    conList= new List<Contact>();
    attachList= new List<Attachment>();  
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    
    Contact contact = new Contact();
    contact.FirstName = email.fromname.substring(0,email.fromname.indexOf(' '));
    contact.LastName = email.fromname.substring(email.fromname.indexOf(' '));
    contact.Email = envelope.fromAddress;
    insert contact;
    
    System.debug('====> Created contact '+contact.Id);
    
    if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
        for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
            Attachment attachment = new Attachment();
            // attach to the newly created contact record
            attachment.ParentId = contact.Id;
            attachment.Name = email.binaryAttachments[i].filename;
            attachment.Body = email.binaryAttachments[i].body;
            insert attachment;
            attachList.add(attachment);   
        }
    }

    if(attachList.size() >0){
        insert attachList; 
    }
    return result;
    }
    public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
        bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    } 
}