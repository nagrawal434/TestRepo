public class InLineVfPageController{
    public Contact ConList{get;set;}
    public InLineVfPageController(ApexPages.StandardController sc){
        
        conList = (contact)sc.getRecord();
        conList = [Select firstname,lastname,email,phone from contact where id =: sc.getId()];
    
    }
    
    
    }