public class SortingController{

    public List<Task> tasks;
    public Integer CountTotalRecords{get;set;}
    public String QueryString {get;set;}
    public Integer OffsetSize = 0;
    private Integer QueryLimit = 3;
    public List<Task> lstTasks;
    public String searchText {get;set;}

    public string sortField = 'Subject';  // default sort column
    private string sApplySOQL = ''; 

// the current sort direction. defaults to ascending
    public String sortDir {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
    }

    // the current field to sort by. defaults to role name
    public String getsortField() {
        return sortField;
    }

    // the current field to sort by. 
    public void setsortField(string value) {
        sortField = value;
    }
             
    // toggles the sorting of query from asc<-->desc
    public void toggleSort() {
        // simply toggle the direction
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
       
        integer iIndex = sApplySOQL.indexOf('Order By');
        if (iIndex > -1){
          sApplySOQL = sApplySOQL.substringBefore('Order By');
          sApplySOQL = sApplySOQL + ' Order By ' + sortField + ' ' + sortDir;
        }
        tasks = Database.query(sApplySOQL );
    }
   
    public SortingController(){
        //CountTotalRecords= [select count() from Task];
    }
 


    public List<Task> getTasks(){
        if(tasks == null){
            tasks = new List<Task>();
        }
        return tasks;
    }
 
    public void findTasks(){
        String qStr2 = 'Select count() from Task where Subject like \'%'+searchText+'%\' OR Status like \'%'+searchText+'%\'';
        CountTotalRecords = Database.countQuery(qStr2);
        queryTasks();
    }
 
    public void  queryTasks(){
        String qStr = 'Select OwnerId,Subject,Status,Priority from Task where Subject like \'%'+searchText+'%\' OR Status like \'%'+searchText+'%\' Order By Subject,Status limit ' + QueryLimit + ' offset ' + OffsetSize;
        sApplySOQL = qStr;
       
        tasks = Database.query(sApplySOQL );
        //tasks.sort();

    }

    public Boolean getDisablePrevious(){
        if(OffsetSize>0){
            return false;
        }
        else return true;
    }

    public Boolean getDisableNext() {
        if (OffsetSize + QueryLimit < countTotalRecords){
            return false;
        }
        else return true;
    }

    public PageReference Next() {
        OffsetSize += QueryLimit;
        queryTasks();
        return null;
    }

    public PageReference Previous() {
        OffsetSize -= QueryLimit;
        queryTasks();
        return null;
    }

      public PageReference save() {
        update tasks;
        return ApexPages.CurrentPage();
     }
  
    }