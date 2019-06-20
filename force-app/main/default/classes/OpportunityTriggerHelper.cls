public class OpportunityTriggerHelper{
    
    public Static void creteNewCloneOpp(List<Opportunity> OppList){
        Set<Id> OppIdSet = new Set<Id>();
        List<OpportunityLineItem> oppLineItemList = new List<OpportunityLineItem>(); 
        List<OpportunityLineItem> NewoppLineItemList = new List<OpportunityLineItem>();
        List<Opportunity> tempList = new List<Opportunity>();
        Opportunity LastOpp = new Opportunity(); 
        List<Opportunity> DecOppList = new List<Opportunity>();
        tempList = [select id,name,CloseDate,StageName from  Opportunity Where id = :OppList];
        system.debug('###' + OppList);
        DecOppList = [select id,name,CloseDate,StageName,(SELECT Id,name,Quantity,TotalPrice FROM OpportunityLineItems) from opportunity ORDER BY createddate DESC]; 
        if(DecOppList.size() >0){
            for(Opportunity op : DecOppList){
                if(op.OpportunityLineItems.Size()>0){
                    LastOpp=op;
                    OppIdSet.add(op.id);
                    Break; 
                }
            }
        }
        system.debug('Welcome' +DecOppList);
        system.debug('Welcome2'+OppIdSet);
        oppLineItemList =   [select Id,name,Quantity,TotalPrice,Description,priceBookEntryId FROM OpportunityLineItem Where OpportunityId IN: OppIdSet];  
        System.debug('%%' + oppLineItemList);
        if(oppLineItemList.size() > 0){
            for(Opportunity o : tempList){
                o.Name=LastOpp.name;
                for(OpportunityLineItem  newItem : oppLineItemList){            
                    OpportunityLineItem oLIOBJ = new OpportunityLineItem(
                    PricebookEntryId = newItem.priceBookEntryId,
                    Quantity = newItem.Quantity,
                    TotalPrice = newItem.TotalPrice,
                    Description = newItem.Description,
                    OpportunityId = o.id);
                    NewoppLineItemList.add(oLIOBJ);
                }
           }
       }
       if(NewoppLineItemList.size() >0){ 
          update tempList;         
          insert NewoppLineItemList;
       } 
        
        
        
    }
}