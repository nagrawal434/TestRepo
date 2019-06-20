public class SendMailToContact{
    public  String contactId{get;set;}
    public List<contact> contactList{get;set;}
    public String Subject{get;set;}
    public String body{get;set;}
    public String getOptions{get;set;}
    public Boolean viewAttachment{get;set;}
    public Boolean viewDocument{get;set;}
    public Boolean viewSystemFile{get;set;}
    public Boolean viewEmailAttachment{get;set;}
    public List<AttactmentModel> attactmentModelList{get;set;}
    public List<DocumentModel> documentModelList{get;set;}
    public List<Document> documentList{get;set;}
    public List<Attachment> attachmentList{get;set;}
    public transient Blob fileBody { get; set; }
    public String contentType { get; set; }
    public String fileName { get; set; }
    public Boolean file{get;set;}
    public String documnetId{get;set;}
    public String attachmnetId{get;set;}
    public Boolean checker{get;set;}
    public Boolean subjectFlag{get;set;}
    public SendMailToContact(){
        if(ApexPages.currentPage().getParameters().get('id') != null){
            contactId = ApexPages.currentPage().getParameters().get('id');
            ShowContact();
        }
        checker = true;
        attactmentModelList = new List<AttactmentModel>();
        documentModelList = new List<DocumentModel>();
        documentList = new List<Document>();
        attachmentList = new List<Attachment>();
    }
    private void ShowContact(){
        List<String> contactIdList = contactId.split(',');
        set<id> conId = new set<id>();
        for(String id : contactIdList){
            conId.add(id);
        }
        contactList = new List<contact>();
        for(contact con : [select id,name,email,firstName,LastName,phone from contact where id in: conId]){
            contactList.add(con);
        }
    }
    public List<SelectOption> getoptions(){
        List<SelectOption> option = new List<SelectOption>();
        option.add(new SelectOption('','--none--'));
        option.add(new SelectOption('Attactment','Attachment'));
        option.add(new SelectOption('Document','Document'));
        option.add(new SelectOption('System File','System File'));
        return option;
    }
    public void selectType(){
        system.debug('@@@@ getOptions' + getOptions);
        if(getOptions == 'Attactment'){
            attactmentModelList.clear();
            documentModelList.clear();
            attactmentDetail();
            viewAttachment = true;
            viewDocument = false;
            viewSystemFile = false;
        }else if(getOptions == 'Document'){
            documentModelList.clear();
            attactmentModelList.clear();
            documentDetail();
            viewAttachment = false;
            viewDocument = true;
            viewSystemFile = false;
        }else if(getOptions == 'System File'){
            attactmentModelList.clear();
            documentModelList.clear();
            viewAttachment = false;
            viewDocument = false;
            viewSystemFile = true;
        }else{
            attactmentModelList.clear();
            documentModelList.clear();
            viewAttachment = false;
            viewDocument = false;
            viewSystemFile = false;
            checker = true;
        }
    }
    public void attactmentDetail(){
        
        for(attachment attach : [select name,ContentType,BodyLength,id,body from attachment]){
            AttactmentModel modelObj = new AttactmentModel();
            modelObj.attach = attach;
            attactmentModelList.add(modelObj);
        } 
        
    }
    public void documentDetail(){
        
        for(document doc : [select name,Type,BodyLength,id,ContentType,body from document]){
            DocumentModel modelObj = new DocumentModel();
            modelObj.doc = doc;
            documentModelList.add(modelObj);
        }  
    }
    public class AttactmentModel{
        
        public Attachment attach{get;set;}
        public Boolean flag{get;set;}
    }
    public class DocumentModel{
        
        public Document doc{get;set;}
        public Boolean flag{get;set;}
    }
    public void attachFile(){
    
        system.debug('inside');
        if(getOptions == 'Attactment'){
            attachmnetId = '';
            for(AttactmentModel modelObj : attactmentModelList){
                system.debug('inside');
                if(modelObj.flag == true)
                    attachmnetId += modelObj.attach.id + ',';
            }
           if(attachmnetId == null){
                checker = true;
                apexpages.addmessage(new Apexpages.Message(ApexPages.Severity.error,' Please select any attachmnet'));
            }else{
                attachmnetId = attachmnetId.removeStart('null'); 
                checker = false;
            }
        }else if(getOptions == 'Document'){
            for(DocumentModel modelObj : documentModelList){
                if(modelObj.flag == true)
                    documnetId += modelObj.doc.id + ',';
            }
            if(documnetId == null){
                checker = true;
                apexpages.addmessage(new Apexpages.Message(ApexPages.Severity.error,' Please select any Document'));
            }else{
                documnetId = documnetId.removeStart('null');
                checker = false;
            }
        }else if(getOptions == 'System File'){
            system.debug('@@@ fileBody' + fileBody);
            if(fileBody == null){
                apexpages.addmessage(new Apexpages.Message(ApexPages.Severity.Error,' Please attach any file')); 
                checker = true;
            }
            else{
                Document doc = new Document(FolderId=UserInfo.getUserId(), Name=fileName, Body=fileBody, ContentType=contentType);
                insert doc;
                documnetId = doc.id;
                checker = false;
                system.debug('@@@' + documnetId);
            }
             
        }else{
            checker = true;
        }
        viewEmailAttachment = true;
    }
    public void refresh(){
        system.debug('@@@@@@@@ inside' + documnetId + attachmnetId );
        set<id> AId = new set<id>();
        if(documnetId != ''){
            List<String> docIdList = documnetId.split(',');
            for(String id : docIdList){
                AId.add(id);
            }
            for(document doc : [select name,ContentType,BodyLength,id,body from document where id in: AId]){
                documentList.add(doc);
            }
        }else if(attachmnetId != ''){
            List<String> attachIdList = attachmnetId.split(',');
            for(String id : attachIdList){
                AId.add(id);
            }
            for(attachment attach : [select name,ContentType,BodyLength,id,body from attachment where id in: AId]){
                attachmentList.add(attach );
            }
        }
        viewEmailAttachment = true;
    }
    
    public void sendEmail(){
       if(subject == ''){
           subjectFlag = true;
           apexpages.addmessage(new Apexpages.Message(ApexPages.Severity.error,' Please sepecify subject'));
       }else{
           subjectFlag = false;
           system.debug('@@@@@@@ inside');
           List<Messaging.SingleEmailMessage> allMails;
           List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
           if(attachmentList.size()>0){
               for (Attachment a : attachmentList){
                    Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                    efa.setFileName(a.Name);
                    efa.setBody(a.Body);
                    fileAttachments.add(efa);
                } 
           }
           if(documentList.size()>0){
               for(document a : documentList){
                    Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                    efa.setFileName(a.Name);
                    system.debug('@@@@ a.Body' + a.Body);
                    efa.setBody(a.Body);
                    fileAttachments.add(efa);
                } 
           }
           system.debug('@@@@@@@' + fileAttachments);
           system.debug('@@@ contactList' + contactList);
           List<String> toAddresses;
           for(contact con : contactList){
               allMails = new List<Messaging.SingleEmailMessage>();
               toAddresses = new List<String>();
               toAddresses.add(con.email);
               Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
               mail.setToAddresses(toAddresses);
               mail.setSubject(subject);
               mail.setFileAttachments(fileAttachments);
               mail.setHtmlBody(body == '' ? 'This is an email': body);
               allMails.add(mail);
               Messaging.sendEmail(allMails);
               system.debug('@@@@@@@' + mail);
           }
       }
    }
}