({
	createItem : function(component, item) {
		var theItems = component.get("v.items");	
        var newItem = JSON.parse(JSON.stringify(item));    
            theItems.push(newItem);
            component.set("v.items", theItems);
			component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c','Name': '','Quantity__c': 0,
                    'Price__c': 0,'Packed__c': false });
	}
})