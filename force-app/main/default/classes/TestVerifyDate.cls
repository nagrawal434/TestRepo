@isTest
    private class TestVerifyDate{
        @isTest Static void myTest(){
            Date d2 = date.newInstance(1992, 2, 21);
            Date d1 = date.newInstance(1991, 2, 21);
            VerifyDate obj = new VerifyDate();
            Date ChkDt = VerifyDate.CheckDates(d1,d2);
        }
        @isTest Static Void myTestsec(){
            VerifyDate obj = new VerifyDate();
            Date d1 = date.newInstance(1992, 2, 21);
            Date d2 = date.newInstance(1992, 2, 23);
            Date ChkDt = VerifyDate.CheckDates(d1,d2);
        }
    }