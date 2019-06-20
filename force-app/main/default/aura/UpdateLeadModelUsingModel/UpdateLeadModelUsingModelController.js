({
	doInit : function(component, event, helper) {
		var leadRecId = component.get('v.recordId');
        alert('Lead Record id' +leadRecId);
        handler.fetchLeadRecord(component,event,leadRecId);
	}
})