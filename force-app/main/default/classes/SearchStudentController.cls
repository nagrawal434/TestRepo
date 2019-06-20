public class SearchStudentController{
    /*
        Name           : Neha Agrawal
        Author         :
        Date           : 04/01/2016
        Desctiption    : Search Contact Records With Sorting and Pagination
    */
    public String nameSearch{get;set;}
    Public Contact condb{get;set;}
    public String fatherName{get;set;}
    public Date dob{get;set;}
    public List<Contact> conList{get;set;}
    public integer totalRecs = 0;     
    public integer index = 0;
    public integer blockSize = 5;
    public String defaultSortColumn = 'Name';
    private String sortDirection = 'ASC';
    public String selectedOption{get;set;}
    public string sortField = 'Student Name'; // default sort column
    public string sApplySOQL = '';
    public SearchStudentController(){
        totalRecs = [select count() from contact];        
        conList = new List<Contact>();
        condb = new Contact();
        conList = database.query('Select id,name,Father_Name__c,birthdate,Status__c from Contact Order By name Asc LIMIT :blockSize OFFSET :index');
    }
   public List<SelectOption> getSearchOptions() {
        List<SelectOption> Options = new List<SelectOption>();
        Options.add(new SelectOption('','-None-'));
        Options.add(new SelectOption('NEW','New'));
        Options.add(new SelectOption('Current','Current'));
        Options.add(new SelectOption('Old','Old'));
    return Options;
    }
    public pageReference searchMethod(){
        System.debug('$$$$' +selectedOption);
        conList = new List<Contact>();
        String Query ='select id,name,Father_Name__c,birthdate,Status__c  from contact Where id != null' ;
        if((!String.ISBLANK(nameSearch))){
            query+= ' And name Like \'%' +nameSearch +'%\'';
        }
        
        if(!String.ISBLANK(fatherName)){
             query+= ' AND Father_Name__c Like \'%' +fatherName+'%\'';
        }
       dob = condb.birthdate;
       if(dob != null){
             query+= ' AND birthdate =: dob';   
       } 
       if(!String.ISBLANK(selectedOption)){
           System.debug('!!!' +selectedOption);
           String newVar = 'NEW';
           String currentVar = 'Current';
           String oldVar= 'Old';
           if(selectedOption == newVar)
           query+= ' And Status__c =: newVar ';
           if(selectedOption == currentVar)
           query+= ' And Status__c =: currentVar ';
           if(selectedOption == oldVar)
           query+= ' And Status__c =: oldVar ';                   
       }
        
        system.debug('Query' + query);
        conList = Database.Query(query);
     return null;
    }
    public PageReference setParam(){
         dob = dob; 
    return null; 
    }
    public void beginning(){
        index = 0;
    }
    public void previous(){
        index = index - blockSize;
        if(sortDir.equals('asc'))
        conList = database.query('Select id,name,Father_Name__c,birthdate,Status__c from Contact Order By name ' +  sortDir + ' LIMIT ' + blockSize + ' OFFSET  ' + index);
        if(sortDir.equals('desc'))
        conList = database.query('Select id,name,Father_Name__c,birthdate,Status__c from Contact Order By name ' +  sortDir + ' LIMIT ' + blockSize + ' OFFSET  ' + index);
        
    }
    public void next(){
        System.debug('$$$$$' +index);
        index = index + blockSize;
        if(sortDir.equals('asc'))
        conList = database.query('Select id,name,Father_Name__c,birthdate,Status__c from Contact Order By name ' +  sortDir + ' LIMIT ' + blockSize + ' OFFSET  ' + index);
        if(sortDir.equals('desc')) 
        conList = database.query('Select id,name,Father_Name__c,birthdate,Status__c from Contact  Order By name ' +  sortDir + ' LIMIT ' + blockSize + ' OFFSET  ' + index);
        
    }
      public void end(){
        index = totalrecs - math.mod(totalRecs,blockSize);
        conList = database.query('Select id,name,Father_Name__c,birthdate,Status__c from Contact Order By name Asc LIMIT :blockSize OFFSET :index');
    } 
     public boolean getprev(){
        if(index == 0)
        return true;
        else
        return false;
    }  
    
    public boolean getnxt(){
        if((index + blockSize) > totalRecs)
        return true;
        else
        return false;
    }
    public boolean SearchPrev(){
        return true;
    }  
    
    // toggles the sorting of query from asc<-->desc
    public void toggleSort(){
        conList = new List<Contact>();
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        sApplySOQL  = 'select id,name,Father_Name__c,birthdate,Status__c from Contact Order By name ' +  sortDir + ' LIMIT ' + blockSize + ' OFFSET  ' + index; 
        conList = Database.query(sApplySOQL);
        System.debug('$$$$$' +index);
      
    }
    // the current field to sort by. defaults to role name
    public String getsortField() {
        return sortField;
    }
    // the current field to sort by. 
    public void setsortField(string value) {
        sortField = value;
    }
    // the current sort direction. defaults to ascending
    public String sortDir{
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir; }
        set;
    }
}