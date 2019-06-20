({
   getRecord: function(cmp){
       var action = cmp.get("c.getCaseFromId");
       action.setCallback(this, function(response){
           var state = response.getState();
           console.log(state);
           if (state === "SUCCESS") {
               cmp.set("v.record.Subject", response.getReturnValue());
           }
       });
    $A.enqueueAction(action);
   }
})