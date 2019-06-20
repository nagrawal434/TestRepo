public class EmailPdfController{
    /* 
        Name : Neha Agrawal
        Date : 07/01/2016
        Author : 
        Description : Send Email And Pdf 
    */
    public List<ModelClass> modelList{get;set;}
    public List<Contact> conList{get;set;}
    public Integer pageVal{get;set;}
    public Integer firstRecordIndx{get;set;}
    public Integer endRecordIndx{get;set;}
    public Integer IntValue{get;set;}
    public Integer AllContactSize{get;set;}
    public Integer j;
    public Integer pageNo{get;set;}
    public String[] addrList;
    public EmailPdfController(){
        modelList = new List<ModelClass>();
        j = 0;
        pageVal = 1;
        conList = new List<Contact>();
        addrList = new String[]{};
        conList = [select name,Father_Name__c,birthdate,email,DetailFee__c from Contact Order By name ASC];
        firstRecordIndx= 0;
        intValue = 10;
        endRecordIndx= intValue;       
        AllContactSize = conList.size();
        if((AllContactSize /intValue)==0){
            pageNo= (AllContactSize /intValue);
        }else{
            pageNo = (AllContactSize /intValue)+1;
        }
        DisplayRecord();
           
    }
    public pageReference sendMailPdf(){
        PageReference pdf = Page.PdfGeneratorTemplate;
        Blob body;
        list<string> sentMail= new list<string>();
        for(ModelClass  ob : modelList){
           system.debug('.........'+modelList);
            if(ob.Chk == true){            
                try{
              // returns the output of the page as a PDF
                pdf.getParameters().put('id',ob.con.id);
                addrList.add(ob.Con.email);
                if(test.isrunningtest()){
                    body = blob.valueOf('strier');
                }else{
                    body = pdf.getContent();
                }
                //body = blob.valueOf('strier');
                Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                attach.setContentType('application/pdf');
                attach.setFileName('testPdf.pdf');
                attach.setInline(false);
                attach.Body = body;
                List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToaddresses(addrList);
                email.setSubject('Contact Pdf');
                email.setHtmlBody('Here is the email you requested! Check the attachment!');
                email.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});
                emails.add(email);
                Messaging.sendEmail(emails);
                addrList.clear();
                } catch(VisualforceException e){
              body = Blob.valueOf('Sorry Can Not Loaded');
              }    
           }
       }
          return new pageReference('/apex/EmailPdfPage').setRedirect(true); 
    }
    public void DisplayRecord(){
        modelList = new List<ModelClass>();
        for(integer i=firstRecordIndx; i<endRecordIndx&& conList.size() > i ;i++){
            ModelClass obj = new ModelClass();
            obj.con = conList[i];
            obj.Chk = false;
            modelList.add(obj);
            j++;
        }
    }
    public void beginning(){
        firstRecordIndx = 0 ;
        endRecordIndx = intValue;
        for(ModelClass mEmail :modelList){
                if(mEmail.Chk == true){
                addrList.add(mEmail.Con.email);
            }
         }   
        DisplayRecord();
    }
    public void previous(){
        pageVal = pageVal - 1;
        endRecordIndx = firstRecordIndx; 
        firstRecordIndx -= intValue;         
        if(firstRecordIndx < 0){
            firstRecordIndx = 0;
            endRecordIndx = intValue;
        }
           for(ModelClass mEmail :modelList){
                if(mEmail.Chk == true){
                addrList.add(mEmail.Con.email);
               }
               
           }
           
               
        DisplayRecord();
    }
    public void next(){
        if(endRecordIndx < conList.size() ){
            pageVal = pageVal + 1;
            firstRecordIndx = endRecordIndx;
            endRecordIndx += intValue;
            for(ModelClass mEmail :modelList){
                if(mEmail.Chk == true){
                addrList.add(mEmail.Con.email);
                }
            }
            DisplayRecord();
        }
    }
    public void end(){
        if(endRecordIndx < conList.size() ){
            firstRecordIndx = conList.size()-intValue;
            endRecordIndx = conList.size();
            for(ModelClass mEmail :modelList){
                if(mEmail.Chk == true){
                addrList.add(mEmail.Con.email);
                }
            }    
            DisplayRecord();
        }
    }  
        
    
    public class ModelClass{
        public Contact Con{get;set;}
        public Boolean Chk{get;set;}
        public ModelClass(){
            Con = new Contact();

        } 
    }
}