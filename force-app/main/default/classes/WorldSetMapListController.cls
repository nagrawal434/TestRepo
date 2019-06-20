public class WorldSetMapListController{
    public List<World__c> wrd{get;set;}
    public String countrySelect{get;set;}
    public String stateSelect{get;set;}
    public Set<String> csl{get;set;}
    public Set<String> stateSet{get;set;}
    public Set<String> citySet{get;set;}
    public Map<String,List<String>> countrystatemap;
    public Map<String,List<String>> statecitymap;
    
      public WorldSetMapListController()
       {
             countrystatemap = new Map<String,List<String>>();
             statecitymap = new  Map<String,List<String>>();
                 wrd = new List<World__c>();
             csl=new Set<String>();
             stateset = new Set<String>();
             citySet= new Set<String>();
              wrd=[select id,Country__c,States__c,City__c from World__c];
                    for(World__c wrdrecord: wrd){
                       csl.add(wrdrecord.Country__c);
       
                     }
                    for(World__c wrdrecord:wrd){
                                  List<String> states = countrystatemap.get(wrdrecord.Country__c);
                              List<String> cities = statecitymap.get(wrdrecord.States__c);
                           if(states == null) {
                                states = new List<String>();
                           }
                                if(cities ==null){
                                         cities = new List<String>();
                                 }
                             states.add(wrdrecord.States__c);
                             cities.add(wrdrecord.City__c);
                        
                          countrystatemap.put(wrdrecord.Country__c,states);
                          statecitymap.put(wrdrecord.States__c,cities);
                          
                           //system.debug('$$$$'+ csl);
                   }
                   // system.debug('$$$$#'+wrd);
       }
     
                  public List<SelectOption> getcl(){
                     List<SelectOption> returnable= new List<SelectOption>();
                      for(String str : csl){
                               returnable.add(new SelectOption(str,str));
                           } 
                   return returnable;
                 }
                   public List<SelectOption> getstate(){
                     
                     List<SelectOption> returnStateset = new List<SelectOption>();
                     for(String str: stateSet){
                         returnStateset.add(new SelectOption(str,str));
                     }  
                    return returnStateset;
                } 
               
               public List<SelectOption> getcityselect(){
                          List<SelectOption> returncityset = new List<SelectOption>();
                          for(String str : citySet)
                          {
                              returncityset.add(new SelectOption(str,str));
                          }
                          return  returncityset;
               }
                     
                             public void goCountry(){
                              if(countrySelect !=null){
                              stateSet = new Set<String>();
                              citySet = new Set<String>();
                               List<String> states = countrystatemap.get(countrySelect);
                               System.debug('$$$$$'+states);
                                if(states !=null){
                                     for(String str : states){
                                         stateSet.add(str);
                                     }
                                         
                                      }
                                 else{
                                         states = new List<String>();
                                     }
                                 }
            }
                public void goState(){
                    if(stateSelect !=null){
                        citySet = new Set<String>();
                        List<String> cities = statecitymap.get(stateSelect);
                        system.debug('$$$$$'+cities);
                        if(cities !=null){
                            for(String str: cities)
                            {
                               citySet.add(str);
                            }
                         }
                           else{
                                cities= new List<String>();
                           }

                    }
            }
                                
}