@isTest
public class TestSearchStudent{
    @isTest
    public static void test(){
        Sorter_UTIL obj1 = new Sorter_UTIL('as','as');
        obj1.getSortDirection();
        obj1.getColumn();
        obj1.setColumn('ws');
        SearchStudentController obj = new SearchStudentController();
        obj.getSearchOptions();
        obj.searchMethod();
        obj.setParam();
        obj.beginning();
        obj.next();       
        obj.previous();
        obj.end();
        obj.getprev();
        obj.getnxt();
        obj.toggleSort();
        obj.getsortField();
        obj.setsortField('a');

             
    }
}