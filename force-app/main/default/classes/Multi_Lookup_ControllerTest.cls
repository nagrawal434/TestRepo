@isTest
public class Multi_Lookup_ControllerTest{
    @isTest
    public static void doTest(){
        Contact conRecord = new Contact();
        conRecord.LastName = 'Test'; 
        insert conRecord;
        Multi_Lookup_Controller.getsObjectRecord('Contact','test','Phone');
    }
}