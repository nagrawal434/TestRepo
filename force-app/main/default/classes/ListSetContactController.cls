public class ListSetContactController{
    public List<contact> strls{get;set;}
    public contact cont{get;set;}  
    public ListSetContactController()
    {
    strls= new list<contact>();
    cont =new contact();
    strls.add(new contact());
    strls.add(new contact());
    strls.add(new contact());
    system.debug(strls);
    }
    public pagereference savecontact()
    {
        List<Contact> listToInsert = new list<Contact>();
        for(contact c : strls){
            if(c.lastname != null)
                listToInsert.add(c);
        }
        if(listToInsert.size()>0){
            insert listToInsert;
        }
    return new pagereference('/apex/ListSetContact').setRedirect(true);
    }
    
  public void add()
    {
        strls.add(new contact());
    }
    public void deleteRec()
    {
        if(strls.size()>0)
         strls.remove(strls.size()-1);
    }
}