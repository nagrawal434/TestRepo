public class DeleteAttchmentController{
    public Attachment attach{get;set;}
    public String currentPageId{get;set;}
    public DeleteAttchmentController(){
         attach = new Attachment();
         currentPageId = ApexPages.CurrentPage().getParameters().get('id');  
         if(currentpageId != null)
         attach = [Select id from Attachment Where id =: currentPageId];
  }
         public pageReference ok(){
             Delete attach;
             return new pageReference('/apex/page/AttachmentAsspage').setRedirect(true);
         
         } 
         public pageReference cancel(){
         
             return new pageReference('/apex/page/AttachmentAsspage').setRedirect(true); 
         }


}