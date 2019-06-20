({
savephone : function(component, event, helper) {
var text = component.find("phone").get("v.value");
       console.log(text);
       $A.get("e.c:PhoneNumberEvent").setParams({
           phone: text
      }).fire();
}
})