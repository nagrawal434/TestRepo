({
	fetchLeadName : function(component, event, rec) {        
        var action = component.get("c.fetchLeadName1");
        action.setParams({
            'leadId' : rec     
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                component.set('v.leadRecord' , response.getReturnValue());                                
            }else if(state == "Error"){
                $A.log("callback error", response.getError());    
            } 
        });      
        $A.enqueueAction(action);	
	},
    editLeadName : function(component, event){
        component.set("v.isEdit", true);    
    },
    saveLeadRecord : function(component, leadRecord){
        var action = component.get('c.updateLead');
        action.setParams({
            'updateLeadRec' : leadRecord     
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                component.set('v.leadRecord' , response.getReturnValue()); 
                component.set("v.isEdit", false);
                $A.get('e.force:refreshView').fire();
            }else if(state == "ERROR"){
                $A.log("callback error", response.getError());    
            } 
        }); 
        $A.enqueueAction(action);        
    },
})