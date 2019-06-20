public class deleteBlog
{
    public boolean checked{get;set;}
    public List<Contact> memTmpLst;
    public List<mem> memList {get;set;}
    public Contact memb;
    String[] selectedNam = new String[]{};
    List<String> selectednames =new List<String>();
    public List<String> temp {get;set;}
    public List<Contact> memDelList;  
    public Integer i; 
   
    public class mem
    {
      public Contact themem {get; set;}
      public Boolean checked{get; set;}
      
      public mem(Contact m,Boolean s)
      {
        themem = m;
        checked = s;
      }
    }

    public deleteBlog(ApexPages.StandardController controller)
    {
      this.memb = (Contact)controller.getRecord();
    }
   
    public void find()
    {
      String nam = memb.Name;
      memList = new List<mem>();
      if(memList == null)
      {
        memList = new List<mem>();
      }  
      String sql = 'SELECT Name,phone,email FROM Member__c WHERE Name LIKE\'%'+nam+'%\'';
      memTmpLst = Database.query(sql);
      for(Contact m:memTmpLst)
      {
        mem me = new mem(m,false);
        memList.add(me);
      }    
    }   
   
    public void del()
    {
      memDelList = new List<Contact>();
      for(mem m:memList)
      {
        if(m.checked == true)
        {
          if(memDelList==null)
          {
            memDelList = new List<Contact>();
          }
          memDelList.add(m.themem);     
     
        }             
      }
      Delete memDelList;
      find();
    }
}