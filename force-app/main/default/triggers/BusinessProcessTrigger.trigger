trigger BusinessProcessTrigger on Business_Process__c (after Insert) {
    
    List<task> taskList=new List<task>();
    List<Process_Steps__c> objList;  
    Map<Id,List<Process_Steps__c>> processDefinitionMap= new Map<Id,List<Process_Steps__c>>();
    List<Process_Steps__c> newProcessStepList = new List<Process_Steps__c>(); 
    if(trigger.isInsert){
        Set<Id> businessProcessId= Trigger.newMap.keySet();
        List<Process_Steps__c> processStepList= [Select id,Business_Definition__c,Process_Steps__c from Process_Steps__c Where Process_Steps__c = null];
        
        
        for(Process_Steps__c processStep: processStepList){
            if(!processDefinitionMap.containsKey(processStep.Business_Definition__c)){
                 objList=  new List<Process_Steps__c>(); 
            }
            else{  
                objList = processDefinitionMap.get(processStep.Business_Definition__c);      
            }
            objList.add(processStep);
            processDefinitionMap.put(processStep.Business_Definition__c,objList);
        }

        for(Business_Process__c businessProcess: Trigger.new){
            if(businessProcess.Business_Definition__c !=null){
                if(processDefinitionMap.containsKey(businessProcess.Business_Definition__c)){
                    newProcessStepList= processDefinitionMap.get(businessProcess.Business_Definition__c);
                }        
            }
            if(newProcessStepList.size() >0){
                for(Process_Steps__c pro :newProcessStepList){
                    Task objTask= new Task();
                    if(businessProcess.contact__c != null){
                        objTask.WhoId= businessProcess.contact__c;
                        objTask.OwnerId= businessProcess.OwnerId;
                        objTask.subject= pro.name;
                        objTask.Priority= 'High';
                        taskList.add(objTask);
    
                    }
                }
            }
        }  
        if(taskList.size() >0){
            insert taskList; 
        }      
    }
}