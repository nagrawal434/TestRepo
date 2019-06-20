({
	search : function(component, event, helper) {
		var searchKeyId = component.find("searchId");
        var srcValue = searchKeyId.get("v.value");
        if(srcValue == '' || srcValue == null){
            searchKeyId.set("v.errors", [{message: "Enter search value"}]);	   
        }else{
        	searchKeyId.set("v.errors", null);	  
            helper.searchHelper(component, event);		   
        }
	},
    // this function automatic call by aura:waiting event  
    showSpinner: function(component, event, helper) {
       // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
   },
    
 // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
     // make Spinner attribute to false for hide loading spinner    
       component.set("v.Spinner", false);
    }
    
})