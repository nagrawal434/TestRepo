@isTest
private class PaginationContactControllerTest{
    static testMethod void  pagenationTest(){
        PaginationContactController obj = new PaginationContactController();
        List<Contact> conList =  new List<Contact>();
        Contact con1 = new Contact(firstname = 'a',lastname = 'b',email = 'a@gmail.com');
        Contact con2 = new Contact(firstname = 'c',lastname = 'd',email = 'c@gmail.com');
        conList.add(con1);
        conList.add(con2);
        insert conList;
        obj.fetchRecord();
        obj.show();
        obj.prev();
        obj.next();
        Boolean pre = obj.getPre();
        Boolean nxt = obj.getNxt();
    }
}