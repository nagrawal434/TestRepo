public class selectListMapController{
   public List<World__c> worldList{get;set;}
   private Set<String> countrySet = new Set<String>();
   private Map<String,List<String>> stateMap;
   private Map<String,List<String>> cityMap;
   public String countrySelect{get;set;}
   public Set<String> stateSet{get;set;}
   public List<SelectOption> getCountryList(){
       List<SelectOption> items = new List<SelectOption>();
       for(String str : countrySet){
           items.add(new SelectOption(str , str));
       }
       return items;  
   }
  
   public List<SelectOption> getStateList(){      
       List<SelectOption> items = new List<SelectOption>();
       for(String str : stateSet){
           items.add(new SelectOption(str , str));
       }
       return items;  
   }
  
   public selectListMapController(){
       worldList = new List<World__c>();
       stateSet = new Set<String>();
       stateMap = new Map<String,List<String>>();
       cityMap = new Map<String,List<String>>();
       worldList = [ select id,Country__c,States__c,City__c from World__c ];
       for(World__c record :worldList ){
           countrySet.add(record.Country__c);
       }
       System.debug('$$$4' +worldList);
       For( World__c record : worldList ){
           List<String> states = stateMap.get(record.Country__c);
           List<String> cities = cityMap.get(record.States__c);
           if(states == null) {
               states = new List<String>();
           }
           if(cities ==null){
               cities = new List<String>();
           }
           states.add(record.States__c);
           cities.add(record.City__c);
           stateMap.put(record.Country__c,states);
           cityMap.put(record.States__c , cities);
       }
   }
  
   public void goCountry(){
       if(countrySelect !=null){
           stateSet = new Set<String>();
           List<String> states = stateMap.get(countrySelect);
           System.debug('$$$$$'+states);
           if(states !=null){
               for(String str : states){
                   stateSet.add(str);
               }
           }else{
               states = new List<String>();
           }
       }
   }
}