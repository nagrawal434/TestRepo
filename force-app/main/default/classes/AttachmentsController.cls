public class AttachmentsController{
    public List<Attachment> attachlist{get;set;}
    public List<Attachment> accountattachments{get;set;}
    public List<Attachment> contactattachment{get;set;}
    public List<Attachment> opportunityattachment{get;set;}
    public String selectoption {get;set;}
    public String pId;
    public AttachmentsController(){
       attachlist = new List<Attachment>();
       
       accountattachments = new List<Attachment>();
       contactattachment =  new List<Attachment>();
       opportunityattachment = new List<Attachment>(); 
       attachlist =[select id,name,createddate,ownerid,contenttype,parentid from Attachment];
    }
    public void goSearch()
    {
      
      attachlist = [Select id,name,createddate,ownerid,contenttype,parentid from Attachment];
      accountattachments.clear();
      contactattachment.clear();
      opportunityattachment.clear();
      for(Attachment att : attachlist)
      {
          pId = att.parentid;
          if(pId .startsWith('001'))
          {
              accountattachments.add(att); 
          }
          if(pId.startsWith('003'))
          {
              contactattachment.add(att);
          }
          if(pId.startsWith('006'))
          {
               opportunityattachment.add(att);   
          }
      } 
      if(selectoption == 'account')
      {
               attachlist = accountattachments;  
      }
      else if(selectoption == 'contact')
      {
              attachlist =  contactattachment;
      }
      else if(selectoption == 'opportunity')
      {
              attachlist =  opportunityattachment;
      }  
   } 

}