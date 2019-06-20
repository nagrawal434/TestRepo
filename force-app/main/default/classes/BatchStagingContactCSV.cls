global class BatchStagingContactCSV implements Database.Batchable<sObject>{
    
     global BatchStagingContactCSV(){
         // Batch Constructor                
     }
     
     // Start Method
     global Database.QueryLocator start(Database.BatchableContext BC){
         system.debug('---Start Methode');
         return Database.getQueryLocator('select id,First_Name__c,Last_Name__c,phone__c,Email__c,Error_Message__c from Staging__c');
     }
    
     // Execute Logic
     global void execute(Database.BatchableContext BC, List<sObject>scope){
         List<Contact> conList= new List<Contact>();
         List<Staging__c> toBeDelStageList =new List<Staging__c>(); 
         List<Staging__c> toBeUpdateList  =new List<Staging__c>(); 
         List<Staging__c> stageList = (List<Staging__c>)scope;
         
         for(Staging__c sg: stageList){
             String errorMessage;
             
             // LastName Validation
             if(sg.Last_Name__c == null || sg.Last_Name__c.trim().length() == 0){
                  errorMessage = 'LastName is Required';
                     
             }
             
             // Email Validation
             if(!Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}[.]{0,1}[a-zA-Z]{0,2}',sg.Email__c)){
                 
                 // Email Not in Proper Format And LastName is Not Null
                 errorMessage += 'Email Would in Proper Format';
             }
             
             // Phone No Validation
             if(sg.phone__c.length() <8 || sg.phone__c.length() >12){
                 errorMessage += 'Phone Would Be Greater Then 4 And Less than 12';    
                       
             }  
             // If All Conditions Are Match 
             if(sg.Error_Message__c == null || sg.Error_Message__c == ''){
                 System.debug('####' +sg.Error_Message__c);
                 Contact con = new Contact();
                 con.firstname= sg.First_Name__c;
                 con.lastname= sg.Last_Name__c;
                 con.phone= sg.phone__c;
                 con.email= sg.Email__c;
                 conList.add(con);
                 toBeDelStageList.add(sg);
             }
             else{
                 sg.Error_Message__c = null;
                 sg.Error_Message__c = errorMessage ;
                 toBeUpdateList.add(sg);  
             }                       
         }
         
         // Insert Contact List
         if(conList.size() >0){
             insert conList; 
         }
         
         // Delete Staging Object Which Is Inserted in  Contact Object
         if(toBeDelStageList.size() >0){
             delete toBeDelStageList; 
         }
         
         //  Update Staging Object 
         if(toBeUpdateList.size() >0) 
             upsert toBeUpdateList;              
     }
     global void finish(Database.BatchableContext BC){
         // Logic to be Executed at finish
     }
}