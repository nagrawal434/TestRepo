public with sharing class DragDropController {
 
  public Attachment att{
    get {
      if (att == null)
        att = new Attachment();
      return att;
    }
    set;
  }
  
  public List<SelectOption> getTypes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('txt','txt'));
        options.add(new SelectOption('pdf','pdf'));
        options.add(new SelectOption('JPEG','JPEG'));
        options.add(new SelectOption('JPG','JPEG'));
        options.add(new SelectOption('PNG','PNG'));
        options.add(new SelectOption('docx','docx'));        
        return options;
    }
  
  public PageReference upload() {
     System.debug('Hi' +att);
    att.ParentId='0012800000Bt0RF';
    //document.AuthorId = UserInfo.getUserId();
    //document.FolderId = UserInfo.getUserId(); // put it in running user's folder
 
    try {
      insert att;
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
      return null;
    } finally {
      att.body = null; // clears the viewstate
      att= new Attachment();
    }
 
    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
    return null;
  }
 
}