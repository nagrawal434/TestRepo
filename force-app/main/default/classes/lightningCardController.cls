public class lightningCardController{
    public List<Opportunity> oppList{get;set;}
    /* public lightningCardController(){
        String opportunityId = ApexPages.currentPage().getParameters().get('Id');
        oppList= new List<Opportunity>(); 
        oppList = [Select id,name,(SELECT id,name,quantity,UnitPrice,ServiceDate from opportunityLineItems) from Opportunity 
                                                                                                      WHERE id =:opportunityId];
    } */
    public Opportunity getOpportunity() {
        return [SELECT id, name, 
        (SELECT Id,name,quantity,UnitPrice,ServiceDate
        FROM OpportunityLineItems)
        FROM Opportunity WHERE id = 
        :System.currentPageReference().getParameters().get('id')];
    } 
}