public class ligtningLeadConversionController{
    public Lead leadObject{get;set;}
    public List<SelectOption> contactsOptionList{get;set;}
    public List<SelectOption> caseRecordTypeList{get;set;}
    
    public ligtningLeadConversionController(ApexPages.StandardController controller){
        contactsOptionList =  new List<SelectOption>();
        caseRecordTypeList = new List<SelectOption>();
        String id = ApexPages.currentPage().getParameters().get('id');
        leadObject = [Select id,name,owner.name,Account__c,OwnerId,Account__r.OwnerId from Lead where id = :id];   
        contactsOptionList.add(new SelectOption('1','--None--')); 
        contactsOptionList.add(new SelectOption('2','Create New: Jose Sanchej')); 
        contactsOptionList.add(new SelectOption('3','Merge with existing: Jose Sanchej')); 
         
        //caseRecordTypeList.add(new SelectOption('1','--None--'));  
        for(RecordType typeRecord : [SELECT Id,Name FROM RecordType WHERE SobjectType='Case']){
            caseRecordTypeList.add(new SelectOption(typeRecord.name,typeRecord.Name));  
        }
    }
}