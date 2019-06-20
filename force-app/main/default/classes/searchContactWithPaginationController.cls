public class searchContactWithPaginationController{
    public list<modelContactClass> modelContactClassList{get;set;}
    public List<Contact> conList{get;set;}
    public String Name{get;set;}
    public String Fathername{get;set;}
    public String Status{get;set;}
    public Date dob{get;set;}
    public String sortDirection{get;set;}
    public contact contacts{get;set;}
    public Integer pageVal{get;set;}
    public integer startIndx{get;set;}
    public integer lastIndx{get;set;}
    public integer IntValue{get;set;}
    public integer AllContactSize{get;set;}
    public Integer j;
    public Integer pageNo{get;set;}
    private string searchType;   
    public searchContactWithPaginationController(){
        searchType = 'ASC';
        j = 0;
        pageVal = 1;
        sortDirection = 'ASC';
        contacts = new contact();
        conList = new List<Contact>();
        conList = [select id, name, Father_Name__c, Status__c, Birthdate from contact ORDER BY Name ASC];
        
        startIndx = 0;
        intValue = 10;
        lastIndx = intValue;       
        AllContactSize = conList.size();
         if((AllContactSize /intValue)==0){
            pageNo= (AllContactSize /intValue);
        }else{
            pageNo = (AllContactSize /intValue)+1;
        }
        fillData();
    }
    Private void searchAndSort(Boolean isSearch){
        String Query = 'select id, name, Father_Name__c, Status__c, Birthdate from contact where id != null';
        dob = contacts.Birthdate;
        Status = contacts.Status__c;
        if(Name !=''){
            Query +=' and name Like \'%'+Name+'%\'';
        }
        if(Fathername !=''){
            Query +=' and Father_Name__c Like \'%'+Fathername+'%\'';
        }
        if(dob != null){
            Query +=' and birthdate =: dob';
        }
        if(Status != null && Status == 'Pending'){
            Query +=' and Status__c =: Status';
        }
        if(Status != null && Status == 'Complete'){
            Query +=' and Status__c =: Status';
        }
        if(isSearch)
            Query +=' ORDER BY Name '+ searchType;
        system.debug('###'+Query);
        conList = Database.Query(Query);
        fillData();
    }
    public void SearchRecord(){
        searchAndSort(false);
    }
    public void sortRecord(){
        if(sortDirection == 'ASC'){
            searchType = 'DESC';
            sortDirection = 'DESC';
        }else if(sortDirection == 'DESC'){
            searchType = 'ASC';
            sortDirection = 'ASC';
        }
        searchAndSort(true);
    }
    public void fillData(){
        modelContactClassList = new list<modelContactClass>();  
        for(integer i=startIndx; i<lastIndx && conList.size() > i ;i++){
            modelContactClass  moc = new modelContactClass();
            moc.con = conList[i];
            moc.sNo = j ;
            modelContactClassList.add(moc);
            j++;
        }
        j=0;
    }
    public void next(){
        if(lastIndx < conList.size() ){
            pageVal = pageVal + 1;
            startIndx = lastIndx ;
            lastIndx += intValue;
            fillData();
        }
    }
    public void prev(){
        pageVal = pageVal - 1;
        lastIndx = startIndx ; 
        startIndx  -= intValue;         
        if(startIndx  < 0){
            startIndx  = 0;
            lastIndx = intValue;
        }
        fillData();
    }
    public void firstRecord(){
        startIndx = 0 ;
        lastIndx = intValue;
        fillData();
    }
    public void lastRecord(){
        if(lastIndx < conList.size() ){
            startIndx = conList.size()-intValue;
            lastIndx = conList.size();
            fillData();
        }
    }
    public class modelContactClass{
        public Contact con{get;set;}
        public Integer sNo{get;set;}
    }
}