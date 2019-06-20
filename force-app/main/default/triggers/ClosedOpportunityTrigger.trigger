trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    List<Task> taskList = new List<task>();
    if(Trigger.isInsert){
        for(Opportunity op: [select id,stageName From Opportunity Where ID IN : Trigger.New]){
            if(op.stageName == 'Closed Won'){
                task tsk = new task();
                tsk.subject = 'Follow Up Test Task';
                tsk.WhatId = op.id;
                taskList.add(tsk);
            }
        }
    }
    If(taskList.size() > 0){
        insert taskList;
    }

}