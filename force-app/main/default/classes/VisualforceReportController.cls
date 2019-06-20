public class VisualforceReportController{
    public List<selectOption> rightOptions{get;set;}
    public List<selectOption> leftoptionsFields{get;set;}
    public Boolean hide{get;set;}
    public Boolean buttonHide{get;set;}
    public String conId{get;set;}
    public List<ModelClass> ModelList{get;set;}
    public List<OpportunityContactRole> roleList;
    public List<OpportunityContactRole> contactRoleList;
    public List<Task> taskList;
    public Set<String> oppIds;
    public VisualforceReportController() {
        rightOptions = new List<selectOption>();
        leftoptionsFields = new List<selectOption>();
        hide = true;
        buttonHide = true;
        ModelList = new List<ModelClass>();  
        conId = ApexPages.currentPage().getParameters().get('id');
        taskList = new List<Task>(); 
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> taskFieldMap = schemaMap.get('Task').getDescribe().fields.getMap();
        Map<String, Schema.SObjectField> opportunityFieldMap = schemaMap.get('Opportunity').getDescribe().fields.getMap();
        Map<String, Schema.SObjectField> opportunityContactRolefieldMap = schemaMap.get('OpportunityContactRole').getDescribe().fields.getMap();
        for(String fieldName : opportunityFieldMap.keyset()){
           leftoptionsFields.add(new SelectOption('Opportunity.' + fieldName, 'Opportunity: ' + fieldName));
        }
        for(String fieldName : opportunityContactRolefieldMap.keyset()){
           leftoptionsFields.add(new SelectOption('OpportunityContactRole' + fieldName, 'OpportunityContactRole:' + fieldName));
        }
        for(String fieldName : taskFieldMap.keyset()){
           leftoptionsFields.add(new SelectOption('Task' + fieldName, 'Task:'+ fieldName));
        }
    }
    public void nextMethod(){
        String opportunityFields = '';
        String OpportunityContactRoleFields = ''; 
        String sqlQuery = '';
        String TaskFields = '';
        String taskSqlQuery = '';
        contactRoleList = [select id,OpportunityId from OpportunityContactRole where ContactId = :conId];
        System.debug('******contactRoleList' +contactRoleList);
        oppIds = new Set<String>();
        for(OpportunityContactRole oppRole : contactRoleList){
            oppIds.add(oppRole.id);   
        }
        
        System.debug('******oppIds' +oppIds);
        for(selectOption field : rightOptions){
            String fieldValue = field.getValue();
            if(fieldValue.startsWith('Opportunity.')){
                opportunityFields = opportunityFields + fieldValue + ',';                
            }        
            else if(fieldValue.startsWith('OpportunityContactRole')){
                fieldValue = fieldValue.remove('OpportunityContactRole');
                OpportunityContactRoleFields = OpportunityContactRoleFields + fieldValue + ',';    
            }  
        }
        if(opportunityFields  != null && OpportunityContactRoleFields == ''){
            opportunityFields = opportunityFields.removeEnd(',');
        }
        if(OpportunityContactRoleFields != null && opportunityFields != null){
            OpportunityContactRoleFields = OpportunityContactRoleFields.removeEnd(',');
        } 
        if(opportunityFields != '' && OpportunityContactRoleFields == ''){
            sqlQuery =  'SELECT' + opportunityFields + 'FROM OpportunityContactRole where ContactId =\''+conId+'\'';
        }
        if(OpportunityContactRoleFields != '' && opportunityFields == ''){
            sqlQuery =  'SELECT' + opportunityFields + OpportunityContactRoleFields + 'FROM OpportunityContactRole where ContactId =\''+conId+'\'';    
        }
        if(OpportunityContactRoleFields != '' && opportunityFields != ''){
            sqlQuery =  'SELECT ' + opportunityFields +  OpportunityContactRoleFields + ' FROM OpportunityContactRole where ContactId =\''+conId+'\'';    
        }
        
        System.debug('******sqlQuery' +sqlQuery);
        if(sqlQuery != '' && sqlQuery != null)
            roleList = database.query(sqlQuery);
        System.debug('******roleList' +roleList);
        
        for(selectOption field : rightOptions){
            String fieldValue = field.getValue();
            if(fieldValue.startsWith('Task')){
                fieldValue = fieldValue.remove('Task');
                TaskFields = TaskFields + fieldValue + ',';                
            }              
        }
        if(TaskFields != ''){
            TaskFields = TaskFields.removeEnd(',');
            taskSqlQuery = 'select ' + TaskFields + ' from Task where WhatId IN : oppIds ' ;                   
            System.debug('******taskSqlQuery' +taskSqlQuery);
        }
            if(taskSqlQuery != '' && taskSqlQuery != null)
            taskList = database.query(taskSqlQuery);
            System.debug('******taskList' +taskList);
    }
    public void previousMethod(){
        hide = true;
        buttonHide = true;
    }
    public class ModelClass{
        public Opportunity oppRecord{get;set;}
        public OpportunityContactRole oppRole{get;set;}
        public List<Task> taskList{get;set;}
        public ModelClass(){
            taskList = new List<Task>();
        }
    }
}