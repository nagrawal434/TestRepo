({
	selectRecord : function(component, event, helper) {
		// get selected record
		var getSelectedRecord = component.get('v.oRecord');
        // call the event
        var compEvent = component.get("oSelectedRecordEvent");
        // set the selected sObject Record to event attribute
        compEvent.setParams({
            "recordByEvent" : getSelectedRecord
        });
        fire the event
        compEvent.fire();
	}
})