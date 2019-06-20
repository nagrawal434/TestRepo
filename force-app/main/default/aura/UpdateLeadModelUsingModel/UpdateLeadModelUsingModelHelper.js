({
	fetchLeadRecord : function(component, event, leadRecId) {
		var action = component.get('c.fetchLeadDetail');        
        action.setParams({
            'leadId' : leadRecId    
        });
        action.setCallback(this, function(responce){
            
        });
        $A.enqueueAction(action);
	},
})