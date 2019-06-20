@isTest
public class TestBatchDailyRecord{
     @isTest
     public static void testBatch(){
      List<Contact> cList = new List<Contact>();
          Contact con = new Contact();
          con.firstname = 'my';
          con.lastname = 'my1';
          con.email = 'my@gmail.com';
          con.phone = '1233';
          con.otherpostalcode = '76699';
          cList.add(con);
          con = new Contact();
          con.firstname = 'my';
          con.lastname = 'my1';
          con.email = 'my@gmail.com';
          con.phone = '';
          con.otherpostalcode = '';
          cList.add(con);
          insert cList;       
      DailyRecordAddBatch obj = new DailyRecordAddBatch();
      database.executebatch(obj);

     }
}