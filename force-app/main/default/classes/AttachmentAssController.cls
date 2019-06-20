public class AttachmentAssController{
    public List<AttachmentModel> modellist{get;set;}
    public String selectValue{get;set;}
    public String AllAttachment{get;set;}
    public List<Attachment> attList{get;set;}
    public String pId{get;set;}
    public Contact accParnt{get;set;}
    public Case    contParnt{get;set;}
    public Partner oppParnt{get;set;} 
    public List<Attachment> finalAttachment{get;set;}   
    public AttachmentAssController(){ 
        modellist= new List<AttachmentModel>(); 
        attList = new List<Attachment>();
        contParnt = new Case();
        accParnt = new Contact();
        oppParnt = new Partner();
        
        for(Attachment a:[Select id,body,name,createddate,contenttype,parentid from Attachment])
        {
             pId = a.parentid;
             if(pId.startsWith('001'))
             {
                  AttachmentModel obj = new AttachmentModel();
                  obj.attachList= a;
                  obj.flag= false;
                  modellist.add(obj);
             
             }
              if(pId.startsWith('003'))
             {
             AttachmentModel obj = new AttachmentModel();
             obj.attachList= a;
             obj.flag= false;
             modellist.add(obj);   
             }
              if(pId.startsWith('006'))
             {
                 AttachmentModel obj = new AttachmentModel();
                 obj.attachList= a;
                 obj.flag= false;
                 modellist.add(obj);
            }
        }
     }
    public class AttachmentModel{
        public Attachment attachList{get;set;}
        public Boolean flag{get;set;}
        public AttachmentModel()
        { 
        attachList = new Attachment();
        }
    } 
       
    public void go(){
       modellist.clear();
       attList = [Select id,name,body,createddate,contenttype,parentid from Attachment];
       for(Attachment a1 : attList)
           {
           pId = a1.parentid;
           if(selectValue  == 'All')
           {
              AttachmentModel obj = new AttachmentModel();
              obj.attachList= a1;
              obj.flag= false;
              modellist.add(obj);   
          }
           if(selectValue == 'account')
           {
               if(pId.startsWith('001'))
               {
                   AttachmentModel obj1 = new AttachmentModel();
                   obj1.attachList= a1;
                   obj1.flag= false;
                   modellist.add(obj1);
               }
           }
           
           else if(selectValue == 'contact')
           {
               if(pId.startsWith('003'))
               {
                   AttachmentModel obj2 = new AttachmentModel();  
                   obj2.attachList= a1;
                   obj2.flag= false;
                   modellist.add(obj2); 
               }
           }
           
           else if(selectValue == 'opportunity')
           {
               if(pId.startsWith('006'))
               {
                   AttachmentModel obj3 = new AttachmentModel();  
                   obj3.attachList= a1;
                   obj3.flag= false;
                   modellist.add(obj3);  
               }
           }
      }
  }
  public pageReference copyAttachment(){
     finalAttachment = new List<Attachment>();
          for(AttachmentModel am : modellist){
               if(am.flag){
                     if(contParnt.contactid != null)
                     {
                        Attachment copy = new Attachment();
                        copy.name = am.attachList.name;
                        copy.body = am.attachList.body;
                        copy.contenttype = am.attachList.contenttype;
                        copy.parentid = contParnt.contactid;
                        finalAttachment.add(copy);
                     }
                    if(accParnt.accountid != null)
                    {
                        Attachment copy = new Attachment();
                        copy.name = am.attachList.name;
                        copy.body = am.attachList.body;
                        copy.contenttype = am.attachList.contenttype;
                        copy.parentid = accParnt.accountid ;
                        finalAttachment.add(copy);
                     }
                    if(oppParnt.opportunityid != null)
                    {
                        Attachment copy = new Attachment();
                        copy.name = am.attachList.name;
                        copy.body = am.attachList.body;
                        copy.contenttype = am.attachList.contenttype;
                        copy.parentid = oppParnt.opportunityid ;
                        finalAttachment.add(copy);
                   }
             }
           }
            if(finalAttachment.size()> 0)
            insert finalAttachment;
            return new pageReference('/apex/AttachmentAsspage').setRedirect(true);
     }  
            
}