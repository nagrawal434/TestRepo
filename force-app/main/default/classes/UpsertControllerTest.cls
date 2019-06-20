@isTest
public class UpsertControllerTest{
    @isTest
    private static void UpsertTestMethod(){
        UpsertContactsController obj2 = new UpsertContactsController();
        obj2.cont.lastname ='ddd';
        obj2.save();
        UpsertContactsController obj1 = new UpsertContactsController();
        // UpsertContactnewController obj1 = new UpsertContactnewController();
        obj1.cont.lastname ='ddd';
        obj1.save();
        contact cont = new contact(lastname ='dd');
        insert cont;
        ApexPages.CurrentPage().getParameters().put('id',cont.id);
        UpsertContactsController obj = new UpsertContactsController ();
        obj.save();
    
    } 

}