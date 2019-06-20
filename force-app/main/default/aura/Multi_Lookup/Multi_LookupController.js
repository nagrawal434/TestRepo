({
    doInIt: function(cmp, event,helper) {
        if(cmp.get("v.slectedsObject") == '' || cmp.get("v.slectedsObject") == 'null' || typeof(cmp.get("v.slectedsObject")) == 'undefined');{
            cmp.set("v.slectedsObject",cmp.get("v.objects")[0]);
        }
    },
    updateTriggerLabel: function(cmp, event,helper) {
        var source = event.getSource();
        var label = source.get("v.label");
        var allObjects = cmp.get("v.objects")
        for(var obj in allObjects){
            if(allObjects[obj].pluralLabel == label){
                cmp.set("v.slectedsObject",allObjects[obj]);
            }    
        }
        var arr = [];
    	cmp.set('v.RecordsList', arr); 
    },
    getRecordsAndFill : function(cmp, event,helper) {
        var Action = cmp.get("c.getsObjectRecord");
        var sortDecField;
        var allobjects = cmp.get("v.objects");
        Action.setParams({sObjectName:cmp.get('v.slectedsObject').objectAPIName,LikeStr:event.getSource().get('v.value'),sortDesciption:cmp.get('v.slectedsObject').sortDesciptionField});
        Action.setCallback(this, function(data) {
            var state = data.getState();
            if (cmp.isValid() && state == "SUCCESS") {
                cmp.set('v.RecordsList', data.getReturnValue());
                if(data.getReturnValue()!=null){
                }
                else {
                } 
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(Action);
	},
    handleBlur : function(cmp, event,helper) {
        var arr = [];
    	//cmp.set('v.RecordsList', arr);    
    },
    selectListItem : function(cmp, event,helper) {
        var recordId = event.target.id;
        var  dataname;
        var allRecords = cmp.get("v.RecordsList");
        for(var Index in allRecords){
            if(allRecords[Index].id == recordId){
        		dataname = allRecords[Index].name;
            }
        }
        if(recordId != '' || typeof  recordId != 'undefined' || recordId != 'null' || dataname == '' || typeof dataname != 'undefined' || dataname == 'null'){
            cmp.set('v.value',recordId);
            cmp.set('v.slectedRecordName',dataname);
            cmp.set('v.slectedRecord',true);
        }  
    },
    handleRemove : function(cmp, event,helper) {
    	cmp.set('v.slectedRecord',false);
    },
    handleClickOfMenuTriggerLink : function(cmp, event,helper) {
    	var arr = [];
    	cmp.set('v.RecordsList', arr);    
    }
})