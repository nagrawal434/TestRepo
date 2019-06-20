({
	doInit : function(component, event, helper) {
        var recId = component.get("v.recordId") 
		helper.fetchLeadName(component,event, recId); 
	},
    editLead : function(component, event, helper){
        helper.editLeadName(component, event);
    },
    SaveRecord : function(component, event, helper){
        helper.saveLeadRecord(component, component.get("v.leadRecord"));
    }
})