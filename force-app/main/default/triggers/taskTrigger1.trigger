trigger taskTrigger1 on Task (after insert,after update){
    Map<id,List<Task>> whoIdTaskMap = new Map<id,List<Task>>();
    List<Task> taskList= new List<Task>();
    set<Id> WhoIdSet= new set<Id>();  
    if(Trigger.isInsert){
        for(Task tsk: Trigger.new){
            WhoIdSet.add(tsk.whoId);                
        }         
        //List<>
        
        List<Business_Process__c> businessProcess= [SELECT id from Business_Process__c Where Contact__r.id IN: WhoIdSet];
        System.debug('********************' +businessProcess);
        
    }
}