({
	loadContacts : function(component, event, helper) {
        helper.onLoad(component,event,'firstName');
	},
    sortFirstName : function(component, event, helper){
        component.set("v.selectedTabsoft", 'firstName');
        helper.sortHelper(component, event, 'firstName');
    },
    sortLastName : function(component, event, helper){
    	component.set("v.selectedTabsoft", 'lastName' );
        helper.sortHelper(component, event, 'lastName');
	},
    sortEmail : function(component, event, helper){
    	component.set("v.selectedTabsoft", 'email' );
        helper.sortHelper(component, event, 'email');
	},
    sortPhone : function(component, event, helper){
    	component.set("v.selectedTabsoft", 'phone' );
        helper.sortHelper(component, event, 'phone');
	},   
})