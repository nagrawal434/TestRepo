public class AttachmentManagerController{

    public List<attachment> attachments{get;set;}
    public string searchvalue1{get;set;}
    public AttachmentManagerController()
    {
      attachments= new list<attachment>();
      attachments= [select parentid,name from attachment]; 
    
    }
}