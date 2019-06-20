public class RecordtypeCollageController{
    public List<College__c> collageRecord1{get;set;}
    public String selectValue{get;set;}
    public Boolean flag{get;set;}
    public College__c clg{get;set;}
    public RecordType rec{get;set;}
    public RecordtypeCollageController(){
     
      collageRecord1 = new List<College__c>();
      clg = new College__c();
      rec = new RecordType();
    } 
    public void search(){
        collageRecord1 = [Select College_Name__c,Principal_Name__c,No_Of_Branch__c,No_Of_Student__c,NoOfTeacher__c,CollegeLink__c,CollegeAddress__c,CollegeId__c,College_No__c,Year_Of_Establish__c from College__c where recordtype.name=:selectValue]; 
        if(selectValue == 'Some Records')
            flag=false;
        if(selectValue == 'All Records')
            flag=true;
            
    }
    public List<SelectOption> getRecordName()
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','----------'));
        for(RecordType rt : [select id,name from RecordType where isActive=true and sObjectType='College__c']){
            options.add(new SelectOption(rt.name,rt.name));
        }
        return options;
    }
    public PageReference save(){
        rec = [select id from recordtype where name=: selectValue and sobjecttype='College__c'];
        clg.recordtypeid = rec.id;
        insert clg;
        return new PageReference('/apex/RecordtypeCollagePage').setRedirect(true);
    }
    public void newRecord(){
        
    }
    
}