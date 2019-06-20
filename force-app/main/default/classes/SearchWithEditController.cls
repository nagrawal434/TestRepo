public class SearchWithEditController
{

        public list<contact> contacts{get;set;}
        public String searchvalue1{get;set;}
        public String searchvalue2{get;set;}
        public contact con{get;set;}
        public contact birthd{get;set;}
        public Date bd{get;set;}
       public SearchWithEditController()
       {
       birthd = new contact();
       contacts =new list<contact>();
       contacts = [select firstname,lastname,phone,email,birthdate from contact]; 
       
       
    }
        public void searchcontact()
        {   
            con =new contact();   
           bd= birthd.birthdate;
          String Query ='select firstname,lastname,email,phone,birthdate from contact where id != null';
           if(searchvalue1 !=''){
                Query +=' and firstname=: searchvalue1';
          }
          if(searchvalue2 !=''){
              Query +=' and lastname=: searchvalue2';
          }
          if(bd!=null){
              Query +=' and birthdate=: bd';
          }
          contacts = Database.Query(Query);
        
}
    public pageReference edit(){
        return new PageReference('/'+con.id);
    }
}