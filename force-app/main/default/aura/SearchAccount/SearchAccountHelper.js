({
	searchHelper : function(component, event) {
		var action = component.get("c.getAccountList");
        action.setParams({
            'searchKeyword' : component.get("v.searchKeyword")
            
        });
        action.setCallback(this, function(response){
        	var state = response.getState();
            if(state == "SUCCESS"){
            	var storeResponce = response.getReturnValue();
                if(storeResponce.length == 0){
                    component.set("v.message", true);                    
                }else{
                	component.set("v.message", false);    
                }
				component.set("v.searchResult",storeResponce);                
            }
        });
        $A.enqueueAction(action);
	},
})