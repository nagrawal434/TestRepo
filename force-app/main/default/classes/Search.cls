public class Search{
    public String con{get;set;}
    public List<Contact> listCon{get;set;}
    public Search(){
    
    }
    public void searchMe(){
        /* this will not work So use Database.query to execute as a string */
        listCon = new List<Contact>();
        listCon = [select id,firstname from contact where firstname like '%con%'];
        System.debug('***' +listCon);
    }
    }