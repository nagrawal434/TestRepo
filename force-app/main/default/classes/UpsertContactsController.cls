public class UpsertContactsController
{
    public contact cont{get;set;}
    
        public UpsertContactsController()
    {
        cont = new contact();
        String contId = ApexPages.CurrentPage().getParameters().get('id');
        if(contId!=null)
        cont=[select id,firstname,lastname,phone,email from contact where id =: contId];
        
    }
    public PageReference save()
    {
        upsert cont;
        return new pageReference('/' +cont.id);
    }
}