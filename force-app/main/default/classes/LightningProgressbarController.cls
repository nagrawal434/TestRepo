public class LightningProgressbarController{

    public String currentStage{get; set;}
    public Integer sCurrentStageNr;
    //Stage List
    public List<String> stageList {get;set;}
    public List<String> completedStage {get;set;}
    public List<String> incompletedStage {get;set;}
    //Stage Map
    public map<Integer, String> mapStageNr2StageValue ;
    public map<String, Integer> mapStageValue2StageNr ;
    
    public LightningProgressbarController(ApexPages.StandardController std){
        String opportunityId = ApexPages.currentPage().getParameters().get('Id');
        
        currentStage='';
        sCurrentStageNr = 0 ;
        
        stageList = new List<String>();
        completedStage = new List<String>();
        incompletedStage = new List<String>();
        
        mapStageNr2StageValue = new map<Integer, String>() ;
        mapStageValue2StageNr = new map<String, Integer>() ;
        
        Opportunity opportunity = [SELECT Id, Name, StageName FROM Opportunity where Id =: opportunityId] ;
        
        currentStage= opportunity.StageName ;
        
        Schema.DescribeFieldResult fieldResult = Schema.Opportunity.StageName.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry s:ple){
            stageList.add(s.getLabel());
        } 
        
        
        for(Integer i = 0; i < stageList.size(); i++){
            mapStageNr2StageValue.put(i+1, stageList[i]) ;
            mapStageValue2StageNr.put(stageList[i], i+1) ;
        }
        
        if(mapStageValue2StageNr.containsKey(currentStage)){
            sCurrentStageNr = mapStageValue2StageNr.get(currentStage) ;
            
            for(Integer i : mapStageNr2StageValue.keySet()){
                if(i< sCurrentStageNr)
                    completedStage.add(mapStageNr2StageValue.get(i)) ;
                else if(i > sCurrentStageNr)
                    incompletedStage.add(mapStageNr2StageValue.get(i)) ;
            }
        }    
    }
}