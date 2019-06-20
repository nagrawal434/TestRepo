({
	onLoad : function(component, event, sortField) {
        var action = component.get('c.fetchContacts');
        
        action.setParams({
            'sortField' : sortField,
            'isAsc' : component.get("v.isAsc")            
        });
        
        action.setCallback(this,function(response){
        	var state = response.getState();
            if(state == 'SUCCESS'){
                component.set('v.ListOfContact', response.getReturnValue());
                console.log('List of Contacts' +component.get("v.ListOfContact"));
            }else if (response.getState() === "ERROR") {
                $A.log("callback error", response.getError());
            }                
        });
        $A.enqueueAction(action);
	},
    sortHelper : function(component, event, sortFieldName){
    	var currentDir = component.get('v.arrowDirection');
        if(currentDir == 'arrowdown'){
        	component.set("v.arrowDirection", 'arrowup');
            component.set("v.isAsc", true);    
        }else{
        	component.set("v.arrowDirection", 'arrowdown');
            component.set("v.isAsc", false);    
        }
        this.onLoad(component, event, sortFieldName);
    },
})