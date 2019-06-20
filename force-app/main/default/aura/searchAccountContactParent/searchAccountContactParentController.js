({
	doInit : function(component, event, helper) {
		
	},
    inputChange : function(component, event, helper){
        var accountId = component.get('v.contact.AccountId');
        if(accountId !=  null && accountId != 'MALFORMED_ID'){
            var appEvent = $A.get("e.c:searchAccountContactEvent");
            appEvent.setParams({ "accountId" : accountId });
            appEvent.fire();
        }
	}
})