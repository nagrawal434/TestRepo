({
	getAllContacts : function(component, event, helper) {
		var action = component.get("c.getContacts");
        action.setCallback(this, function(responce){            
            	component.set("v.contactRow",responce.getReturnValue());			                    
                
        });
        $A.enqueueAction(action);
	}
})