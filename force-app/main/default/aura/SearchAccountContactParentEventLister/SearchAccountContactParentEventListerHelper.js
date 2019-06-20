({
    fetchContactList : function(component, event, accountIdChild, sortField) {
        console.log('accountId in handler New' +accountIdChild);
        console.log('sortField in handler New' +sortField);
        console.log('ASC in handler New' +component.get('v.isAsc'));
        
        var action = component.get("c.getContactList");
        action.setParams({
            'accountRecId' : accountIdChild,
            'sortField' : sortField,
            isAsc : component.get('v.isAsc')
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('return state' +state);
            if(state == 'SUCCESS'){
                console.log('List Of Contact' +response.getReturnValue()); 
                component.set('v.contactList', response.getReturnValue());
                var storeResponce = response.getReturnValue() ;
                if(storeResponce.length == 0){
                    component.set('v.isListVisible','false');  
                    component.set('v.Message','No Records Found');                      
                }else{
                    component.set('v.isListVisible','true');
                    component.set('v.Message','');                      
                }	
            }else{
                alert('There is some issue');
            }
        });
        $A.enqueueAction(action);
    },
    inlineEditRecord : function(component, event, helper){
    	var ctarget = event.currentTarget;  
        console.log('Current' +ctarget);
        //var id_str = ctarget.dataset.value;
        //console.log('IDS' +id_str);
        var parentNodeOfButton = ctarget.parentNode;        
        console.log('PARENT NODE' +event.currentTarget.parentNode.innerHTML);
        var firstChild = event.currentTarget.parentNode.children[0];
        console.log('PARENT NODE' +firstChild);
        var secondChild = event.currentTarget.parentNode.children[1];
        console.log('PARENT NODE' +secondChild);
        $A.util.removeClass(firstChild,"slds-show");
        $A.util.addClass(firstChild,"slds-hide");
        $A.util.removeClass(secondChild,"slds-hide");  
        $A.util.addClass(secondChild,"slds-show");
        component.set('v.isButtonHide',false);        
    },
    saveRecord : function(component, event, helper){
        
        [].slice.bind(document.getElementsByClassName("inputA"))().forEach(function(itm){
          //itm.style.display = "none";
            itm.setAttribute("class", "inputA slds-hide");
        });
        [].slice.bind(document.getElementsByClassName("outPutA"))().forEach(function(itm){
          //itm.style.display = "block";
          itm.setAttribute("class", "outPutA slds-show");
        });
    	console.log('IN save Method' +component.get("v.contactList"));
        var action = component.get("c.inlineupdateContact");        
        action.setParams({
            "conList" : component.get("v.contactList")   
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            //this.superAfterRender();
            if(state == 'SUCCESS'){
            	console.log('Updated List' +response.getReturnValue());								                
            }
        });
        $A.enqueueAction(action);     
    },
    sortHelper : function(component, event, sortField){
		var currentDirection = component.get("v.arrowDirection");
        if(currentDirection == 'arrowDown'){
        	component.set('v.isAsc',true);
            component.set('v.arrowDirection','arrowUp');
        }else{
        	component.set('v.isAsc',false);
            component.set('v.arrowDirection','arrowDown');    
        }        
        this.fetchContactList(component, event, component.get('v.globalAccountId'), sortField);
    },
    inlineFirstNEditRecord : function(component, event, helper){
        
        /*var ctarget = event.currentTarget;
        var selectedRow = ctarget.dataset.recordidn;
        var seletedRecordId = ctarget.dataset.cid;
        var outPutText;
        var inputText;
        console.log('SELECTED ROW' +selectedRow);
        outPutText = component.find('outPutText0')[selectedRow];
        inputText =  component.find('inPutText0')[selectedRow];        
        $A.util.removeClass(outPutText,"slds-show");
        $A.util.addClass(outPutText,"slds-hide");
        $A.util.removeClass(inputText,"slds-hide");  
        $A.util.addClass(inputText,"slds-show");
        component.set('v.isButtonHide',false);
        
        var editableButton = component.find('EditButtonColumn0')[selectedRow];
        $A.util.addClass(editableButton,"slds-hide");
        */
    },
    inlineLastNEditRecord : function(component, event, helper){
        /*var ctarget = event.currentTarget;
        var selectedRow = ctarget.dataset.recordidn;
        var seletedRecordId = ctarget.dataset.cid;
        var outPutText;
        var inputText;
        console.log('SELECTED ROW' +selectedRow);
        outPutText = component.find('outPutText1')[selectedRow];
        inputText =  component.find('inPutText1')[selectedRow];        
        $A.util.removeClass(outPutText,"slds-show");
        $A.util.addClass(outPutText,"slds-hide");
        $A.util.removeClass(inputText,"slds-hide");  
        $A.util.addClass(inputText,"slds-show");
        component.set('v.isButtonHide',false);
        var editableButton = component.find('EditButtonColumn1')[selectedRow];
        $A.util.addClass(editableButton,"slds-hide");
        */
    },
    inlinePhoneEditRecord : function(component, event, helper){
        /*var ctarget = event.currentTarget;
        var selectedRow = ctarget.dataset.recordidn;
        var seletedRecordId = ctarget.dataset.cid;
        var outPutText;
        var inputText;
        console.log('SELECTED ROW' +selectedRow);
        outPutText = component.find('outPutText3')[selectedRow];
        inputText =  component.find('inPutText3')[selectedRow];        
        $A.util.removeClass(outPutText,"slds-show");
        $A.util.addClass(outPutText,"slds-hide");
        $A.util.removeClass(inputText,"slds-hide");  
        $A.util.addClass(inputText,"slds-show");
        component.set('v.isButtonHide',false);
        var editableButton = component.find('EditButtonColumn3')[selectedRow];
        $A.util.addClass(editableButton,"slds-hide");
        */
    },
    inlineEmailEditRecord : function(component, event, helper){
        /*var ctarget = event.currentTarget;
        var selectedRow = ctarget.dataset.recordidn;
        var seletedRecordId = ctarget.dataset.cid;
        var outPutText;
        var inputText;
        console.log('SELECTED ROW' +selectedRow);
        outPutText = component.find('outPutText2')[selectedRow];
        inputText =  component.find('inPutText2')[selectedRow];        
        $A.util.removeClass(outPutText,"slds-show");
        $A.util.addClass(outPutText,"slds-hide");
        $A.util.removeClass(inputText,"slds-hide");  
        $A.util.addClass(inputText,"slds-show");
        component.set('v.isButtonHide',false);
        var editableButton = component.find('EditButtonColumn2')[selectedRow];
        $A.util.addClass(editableButton,"slds-hide");
        */
    },
    
})