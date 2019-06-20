@istest
public class TestSchedule{
    @isTest
    private static void Test(){
        Test.startTest();
        Datetime dt = Datetime.now().addMinutes(1);
        String CRON_EXP = '0 '+ dt.minute() + ' * ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
        String jobId = System.schedule('scheduledBatchable', CRON_EXP, new scheduledBatchable());   
        Test.stopTest();
    }

}