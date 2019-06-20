public class UpsertContactController
{
    public contact cont{get;set;}
    public UpsertContactController()
    {
        cont = new contact();
        String contId = ApexPages.CurrentPage().getParameters().get('id');
        if(contId!= null)
                cont=[select id,firstname,lastname,email,phone from contact where id=:contId];
                
   }    
   public pageReference save()
   {
       upsert cont;
       return new pageReference('/'+cont.id);
   }
   
}