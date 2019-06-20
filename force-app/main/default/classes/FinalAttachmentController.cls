public class FinalAttachmentController
{
    public List<Attachment> saveCopyAttachment {get;set;}
    public String selectListValue{get;set;}
    public String Attid{get;set;}
    public List<ModelAttachClass> modelList{get;set;}
    public List<Attachment> attach{get;set;}
    
    public Contact acc{get;set;}
    public Case cas{get;set;}
    public Partner part{get;set;}
    
    public FinalAttachmentController()
    {
        attach= new List<attachment>();
        modelList= new List<ModelAttachClass>();
        
        acc= new Contact();
        cas= new Case();
        part= new Partner();
        
        for(Attachment atValue:[select id,name,body,bodylength,contenttype,parentid from attachment])
        {
            ModelAttachClass mac = new ModelAttachClass();
            
            mac.flagValue=false;
            mac.attachList=atValue;
            modelList.add(mac);
            
        }
        
    }
    public class ModelAttachClass
    {
        public boolean flagValue{get;set;}
        public attachment attachList{get;set;}
        public ModelAttachClass()
        {
            flagValue=false;
            attachList= new attachment();
        }
    }
    public void showSelectedList()
    {
        attach=[select id,name,body,bodylength,contenttype,parentid from attachment];
        modelList.clear();
        for(attachment a :attach)
        {
            String sid=a.parentid;
            if(selectListValue=='All')
            {
                     ModelAttachClass mac1 = new ModelAttachClass();
                      mac1.flagValue = false;
                      mac1.attachList = a;
                      modelList.add(mac1);
            }
            else if(selectListValue=='Account')
            {
                if(sid.startsWith('001'))
                {
                    ModelAttachClass mac1 = new ModelAttachClass();
                      mac1.flagValue = false;
                      mac1.attachList = a;
                      modelList.add(mac1);
                }
            }
            else if(selectListValue=='Contact')
            {
                if(sid.startsWith('003'))
                {
                    ModelAttachClass mac1 = new ModelAttachClass();
                      mac1.flagValue = false;
                      mac1.attachList = a;
                      modelList.add(mac1);
                }
            }
            else if(selectListValue=='Opportunity')
            {
                if(sid.startsWith('006'))
                {
                    ModelAttachClass mac1 = new ModelAttachClass();
                      mac1.flagValue = false;
                      mac1.attachList = a;
                      modelList.add(mac1);
                }
            }
            else if(selectListValue=='Lead')
            {
            }
         }
    }
    public pageReference copyAttachment()
    {
         saveCopyAttachment = new List<Attachment>();
          for(ModelAttachClass copyId : modelList){
              if(copyId.flagValue){
                  if(acc.accountId != null){
                      Attachment copyAttachment = new Attachment();
                      copyAttachment.body = copyId.attachList.body;
                      copyAttachment.name = copyId.attachList.name;
                      copyAttachment.ContentType = copyId.attachList.ContentType;
                      
                      copyAttachment.ParentID = acc.accountId;
                      
                      saveCopyAttachment.add(copyAttachment);
                  }
                  if(cas.ContactId != null){
                      Attachment copyAttachment = new Attachment();
                      copyAttachment.body = copyId.attachList.body;
                      copyAttachment.name = copyId.attachList.name;
                      copyAttachment.ContentType = copyId.attachList.ContentType;
                      
                      copyAttachment.ParentID = cas.ContactId;
                      
                      saveCopyAttachment.add(copyAttachment);
                  }
                  if(part.OpportunityId != null){
                       Attachment copyAttachment = new Attachment();
                      copyAttachment.body = copyId.attachList.body;
                      copyAttachment.name = copyId.attachList.name;
                      copyAttachment.ContentType = copyId.attachList.ContentType;
                      
                      copyAttachment.ParentID = part.opportunityId;
                      
                      saveCopyAttachment.add(copyAttachment);
                  }
              }
          }
          if(saveCopyAttachment.size() > 0)
              insert saveCopyAttachment;
              
          return new pageReference('/apex/FinalAttachment').setRedirect(true);
    }
    public pageReference deleteAttachment()
    {
        attachment newAttach = new attachment();
        newAttach = [select  id,name from attachment where id=:Attid];
        
        Delete newAttach;
        return new PageReference('/apex/FinalAttachment').setRedirect(true);
    }
}