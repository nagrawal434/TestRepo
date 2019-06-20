public class WorldMapListController{
    public List<World__c> wrd{get;set;}
    public Set<String> csl{get;set;}
    public Set<String> stateset{get;set;}
    public Set<String> cityset{get;set;}
    public Map<String,Set<String>> countrystate;
    public Map<String,Set<String>> statecity;
    
       public WorldMapListController()
       {
            countrystate = new Map<String,Set<String>>();
            statecity = new  Map<String,Set<String>>();
            wrd = new List<World__c>();
            csl=new Set<String>();
            wrd=[select id,Country__c,States__c,City__c from World__c];
              
            for(World__c wrdrecord: wrd){
                csl.add(wrdrecord.Country__c);
       
        }
      //  system.debug('$$$$'+ csl);
       }
     
       public List<selectoption> getcl(){
           List<selectoption> returnable= new List<selectoption>();
           for(String str:csl){
               returnable.add(new selectoption(str,str));
            } 
            return returnable;
       }

    
        
       
  }