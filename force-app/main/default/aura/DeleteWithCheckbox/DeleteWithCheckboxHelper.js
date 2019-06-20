({
	onLoad : function(component, event) {
		var action = component.get("c.fetchContacts");
        action.setCallback(this, function(response){
        	var state = response.getState();
            if(state == 'SUCCESS'){
				component.set("v.ListOfContact",response.getReturnValue()); 
                component.find("box3").set("v.value",false);
                component.set("v.selectedCount", 0);
            }
        });
        $A.enqueueAction(action);
	},
    deleteContacts : function(component, event, deletedRecIds){
    	var action = component.get("c.deleteContactList");
        action.setParams({
            'recordsId' : deletedRecIds     
        });
        action.setCallback(this, function(response){
        	var state = response.getState();
            if(state == 'SUCCESS'){
                if(response.getReturnValue() != ''){
                    alert('The following error has occurred. while Delete record-->' + response.getReturnValue());
                }else{
                	console.log('check it--> delete successful');    
                }	    
            }
            this.onLoad(component, event);
        });
        $A.enqueueAction(action);
    },
})