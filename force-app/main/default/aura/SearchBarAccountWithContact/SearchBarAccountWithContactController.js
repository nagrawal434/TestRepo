({
	doInit : function(cmp,event)
    {
	    var action=cmp.get("c.FindAll");
        action.setCallback(this,function(a)
        {
            cmp.set("v.contacts1",a.getReturnValue());
                        
        });
        $A.enqueueAction(action);
  	},
    
    handleApplicationEvent : function(cmp,event,helper)
    {
      
	    var search_key= event.getParam("searchkey1");
         alert('search_key---- > ' + search_key);
        var action=cmp.get("c.FindByName");
        
        action.setParams({"searchKey_server":search_key});
        
        action.setCallback(this,function(a)
        {
            alert(a.getReturnValue());
           cmp.set("v.contacts1",a.getReturnValue());
        });
        $A.enqueueAction(action);
	}
  })