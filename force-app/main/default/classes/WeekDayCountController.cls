public class WeekDayCountController{    
    public Contact contactRecord{get;set;}
    public List<Contact> contactList;
    public Map<String,Integer> dayCountMap;
    public WeekDayCountController(){
    String contactId = ApexPages.currentPage().getParameters().get('id');
        dayCountMap =  new Map<String,Integer>();
        contactList = new List<Contact>();
        if(String.isNotBlank(contactId))
            contactList = [SELECT Id,Name,Start_Date__c,End_Date__c from Contact where Id = :contactId];                            
        if(contactList != null && contactList.size() >0)
           contactRecord = contactList[0];
        if(contactRecord.Start_Date__c != null && contactRecord.End_Date__c != null){
            Integer numOfDaysEndStartDate = contactRecord.Start_Date__c.daysBetween(contactRecord.End_Date__c); 
            for(Integer i=0 ; i< numOfDaysEndStartDate  ; i++ ){
                Date dt = contactRecord.Start_Date__c.addDays(i);   
                DateTime dateTimeDt = (DateTime)dt;
                String dayOfWeek =  dateTimeDt.format('EEEE');
                if(dayCountMap.containsKey(dayOfWeek) && dayCountMap.get(dayOfWeek) != null){
                    dayCountMap.put(dayOfWeek,dayCountMap.get(dayOfWeek) + 1);
                }else{
                    dayCountMap.put(dayOfWeek, 1);    
                }    
                System.debug('&&&& dayOfWeek' +dayCountMap);
            }
        }                              
    }
}