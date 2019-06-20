public class JoinRelationHotelAssController{
    public List<Booking__c> bookingList{get;set;}
    public List<ModelJoinQuery> modelList{get;set;}
    public Integer days{get;set;}
    public JoinRelationHotelAssController(){
        bookingList = new List<Booking__c>();
        modelList = new List<ModelJoinQuery>();
        
        bookingList = [Select id,Customer__r.First_Name__c,Customer__r.Last_Name__c,Room__r.Room_No__c,Room__r.Price__c,Check_In_Time__c,Check_Out_Time__c from Booking__c];      
        for(Booking__c bc : bookingList){
             ModelJoinQuery obj = new ModelJoinQuery();
             obj.booking = bc;
             DateTime inTime = (DateTime)bc.Check_In_Time__c;
             DateTime outTime = (DateTime)bc.Check_Out_Time__c;
             if(inTime !=null && outTime != null)
             days =  (inTime.date().daysBetween(outTime.date())); 
             obj.Days = days;
             obj.TotalAmount = (days)*bc.Room__r.Price__c;
             
             modelList.add(obj);    
        } 
        
            
             
      }
      public class ModelJoinQuery{
        public Booking__c booking{get;set;}
        public Integer Days{get;set;}
        public Double TotalAmount{get;set;}
        public ModelJoinQuery(){
            booking = new Booking__c();
        } 
    } 
    }