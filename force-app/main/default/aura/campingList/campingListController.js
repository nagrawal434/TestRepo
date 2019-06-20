({
	clickCreateItem : function(component, event, helper) {
		
        var validItem = true;
        
        //  get and verify the name is set
        var nameField = component.find("campItemName");
        var campname = nameField.get("v.value");
        if ($A.util.isEmpty(campname))
        {
            validItem = false;
            nameField.set("v.errors", [{message: "Camping Item name can't be blank."}]);
        }
        else
        {
            nameField.set("v.errors", null);
        }
        
        //  check quantity
        var quantityField = component.find("quantity");
        var quantityValue = quantityField.get("v.value");
        if ($A.util.isEmpty(quantityValue) || quantityValue == 0)
        {
            validItem = false;
            quantityField.set("v.errors", [{message : "Quantity cannot be 0 or blank."}]);
        }
        else
        {
            quantityField.set("v.errors", null);
        }
        
        //  check price
        var priceField = component.find("price");
        var priceValue = priceField.get("v.value");
        if ($A.util.isEmpty(priceValue) || priceValue == 0)
        {
            validItem = false;
            priceField.set("v.errors", [{message : "Price cannot be 0 or blank."}]);
        }
        else
        {
            priceField.set("v.errors", null);
        }
        
        if (validItem)
        {
            //  gets refernce to view's newItem attribute
            var newItem = component.get("v.newItem");
            console.log("Create Camping Item: " + JSON.stringify(newItem));
            
            helper.createItem(component, newItem);      
        component.set("v.newItem",{'sobjectType':'Camping_Item__c',
                'Name': '',
                'Quantity__c': 0,
                'Price__c': 0,
                'Packed__c': false});
       } 
	}
})