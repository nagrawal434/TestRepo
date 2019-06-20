@isTest
public class TestAddDelConRowController{
    @isTest
    public static void test(){
    Integer indx;
    Contact con = new Contact();
    con.firstname = 'ab';
    con.lastname = 'ab1';
    con.email = 'a@gmail.com';
    con.Father_Name__c = 'rrer';
    insert con;
    ApexPages.currentPage().getParameters().put('rowIndex','1');
    AddDelConRowController obj = new AddDelConRowController();
    obj.addRow();
    obj.deleteRow();
    obj.saveRecord();
    }
}