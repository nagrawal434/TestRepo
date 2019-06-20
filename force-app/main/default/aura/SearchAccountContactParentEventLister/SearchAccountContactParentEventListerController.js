({
	handleApplicationEvent : function(component, event, helper) {
        var selectedAccountGetFromEvent = event.getParam("accountId");         
        if(selectedAccountGetFromEvent != null && selectedAccountGetFromEvent != 'MALFORMED_ID'){
            component.set("v.globalAccountId", selectedAccountGetFromEvent);
            console.log('AccId' +component.get("v.globalAccountId"));
            var sortField = component.get('v.selectedTabSort');
            helper.fetchContactList(component, event, selectedAccountGetFromEvent, sortField);
        }
	},
    EditRecord : function(component, event ,helper){
    	helper.inlineEditRecord(component, event, helper);    
    },
    saveContact : function(component,event,helper){
    	helper.saveRecord(component, event, helper); 	   
    },
    sortFirstName : function(component,event,helper){
        component.set("v.selectedTabSort",'firstname');
        helper.sortHelper(component, event, 'firstname');    
    },
    sortLastName : function(component,event,helper){
        component.set("v.selectedTabSort",'lastname');
        helper.sortHelper(component, event, 'lastname');    
    },
    sortEmail : function(component,event,helper){
        component.set("v.selectedTabSort",'email');
        helper.sortHelper(component, event, 'email');    
    },
    sortPhone : function(component,event,helper){
        component.set("v.selectedTabSort",'phone');
        helper.sortHelper(component, event, 'phone');    
    },
    // 3, 4, 5 and 6 methods are not in use but for future use add this
    EditFirstRecord : function(component, event ,helper){    	
        helper.inlineFirstNEditRecord(component, event, helper);
    },
    EditLastRecord : function(component, event ,helper){
    	helper.inlineLastNEditRecord(component, event, helper);
    },
    EditEmailRecord : function(component, event ,helper){
    	helper.inlineEmailEditRecord(component, event, helper);
    },
    EditPhoneRecord : function(component, event ,helper){
    	helper.inlinePhoneEditRecord(component, event, helper);
    },
    
    
})