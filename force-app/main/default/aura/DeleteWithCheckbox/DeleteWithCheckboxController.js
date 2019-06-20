({
	loadContactList : function(component, event, helper) {
		helper.onLoad(component, event);	
	},
    selectAll : function(component, event, helper){
        var selectAllRec = event.getSource().get("v.value");
        var getAllId = component.find("boxPack");
        if(selectAllRec == true){
            for(var i= 0 ; i < getAllId.length ; i++){
            	component.find("boxPack")[i].set("v.value",true);
                component.set("v.selectedCount",getAllId.length);
            }               
        }else{
        	for(var i= 0 ; i < getAllId.length ; i++){
            	component.find("boxPack")[i].set("v.value",false);
                component.set("v.selectedCount",0);
            }  	    
        }        
    },
    checkboxSelect : function(component, event, helper){
    	var selectedRec = event.getSource().get("v.value");
        var getSelectedNumber = component.get("v.selectedCount");
        if(selectedRec == true)
        	getSelectedNumber++;
        else
            getSelectedNumber--;
     
        component.set("v.selectedCount",getSelectedNumber);
    },
    deleteSelected : function(component, event, helper){
    	var delIds = [];
        var getAllId = component.find("boxPack"); 
        for(var i=0; i < getAllId.length ; i++){
            if(getAllId[i].get("v.value") == true){
            	delIds.push(getAllId[i].get("v.text"));	    
            }				
        }
        helper.deleteContacts(component, event, delIds);
    },    
})