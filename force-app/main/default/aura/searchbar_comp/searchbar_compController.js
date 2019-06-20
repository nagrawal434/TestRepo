({
	searchkeychange:function(component,event,helper) 
    {
		var myEvent = $A.get("e.c:searchkeychange"); 
        myEvent.setParams({"searchkey1":event.target.value});
        myEvent.fire(); 
  	}
})