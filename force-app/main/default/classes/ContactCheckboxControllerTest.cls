@isTest
public class ContactCheckboxControllerTest{
    static list<contact> conlist;
    static contact con;
    @isTest
    static void testCheckbox(){
        
        ContactCheckboxController.ContactModelNew objmodel = new ContactCheckboxController.ContactModelNew();        
        objmodel.flag = true;
        con=new contact(firstname='test', lastname='sejal',email='sejal@gmail.com', phone='8058036269');
        conlist= new list<contact>();
        conlist.add(con);
        insert conlist;
        ContactCheckboxController obj = new ContactCheckboxController();
        obj.contactId = conlist[0].id;
        obj.editContact();
        obj.save();
             
    }
}