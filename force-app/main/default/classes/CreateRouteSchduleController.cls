public class CreateRouteSchduleController{
    public Route__c routeObj{get;set;}
    public ModelClass modelObj{get;set;}
    public CreateRouteSchduleController(){
        routeObj = new Route__c();
        
    }
    public pageReference saveRecord(){
    return new pageReference('/apex/CreateRouteSchdulePage').setRedirect(true); 
    }
    public pageReference cancelRecord(){
    return new pageReference('/apex/CreateRouteSchdulePage').setRedirect(true);     
    }
    public pageReference generateRecord(){
    return new pageReference('/apex/CreateRouteSchdulePage').setRedirect(true);     
    }
    public class ModelClass{
    public Volunteer__c volunteer{get;set;}
    
    public ModelClass(){
        volunteer = new Volunteer__C();    
            
    }
    }
}