public class TaskController
{
    public list<task> tasks{get;set;}
    public String searchselection{get;set;}
    public String searchvalue1{get;set;}
    public String Go{get;set;}
   
    public TaskController()
       {
       
       tasks =new list<task>();
       
       tasks = [select id,subject,priority from task];
       } 
       public void goSearch()
       {
           String Query= 'SELECT id,subject,priority FROM task WHERE ' ; 
        if(searchselection== 'TODAY')
        {
               Query+= ' CreatedDate = TODAY';
        }
        if(searchselection== 'MONTH')
        {
               Query+= ' CreatedDate = THIS_MONTH';
        }
        if(searchselection== 'WEEK')
        {   
               Query+= ' CreatedDate = THIS_WEEK';
        }
        system.debug('Query ' + Query);
               tasks= Database.Query(Query);
       
           
       }
           
}