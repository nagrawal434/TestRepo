public Class PieChartAgeCategory{
    private String todayDate;
    public PieChartAgeCategory(){
        todayDate =System.today().format();
        for(Contact con: [Select id,birthdate from Contact]){
            if(con.birthdate != null){
                System.debug('####' +con.birthdate.format());
            System.debug('####' +con.birthdate.day());
            }
        }
        System.debug('********' +todayDate);
    }
}