public class UpsertAccountController
{
    public Account acc{get;set;}
    public UpsertAccountController()
    {
       acc = new  Account ();
        String contId = ApexPages.CurrentPage().getParameters().get('id');
        if(contId!= null)
                acc=[select id,name,AccountNumber from Account where id=:contId];
                
   }    
   public pageReference save()
   {
       upsert acc;
       return new pageReference('/'+acc.id);
   }
   
}