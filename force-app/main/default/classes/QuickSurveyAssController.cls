public class QuickSurveyAssController{
    public String e1{get;set;}
    public String p1{get;set;}
    public String f1{get;set;}
    public String l1{get;set;}
    public String newEmail{get;set;}
    public List<Contact> contList{get;set;}
    public List<Questions__c> questionList{get;set;}
    public Map<String, List<String>> QuestionMap{get;set;}
    public Set<String> optionSet{get;set;}
    
    public QuickSurveyAssController(){
       contList = new List<Contact>();
       questionList = new  List<Questions__c>();
       QuestionMap = new Map<String, List<String>>();  
       contList = [Select id,name,email,Password__c from Contact where email =: e1 and Password__c =: p1];
       questionList = [Select Question__c,Option1__c,Option2__c,option3__c,option4__c from Questions__c];
       for(Questions__c qrecord : questionList){
           List<String> optionListValue    = QuestionMap.get(qrecord.Question__c);
           if(optionListValue== null){
              optionListValue= new List<String>();  
           }
           optionListValue.add(qrecord.Question__c);
           QuestionMap.put(qrecord.Question__c,optionListValue);
      } 
             
    
    }
    public void loginPage(){
          if(contList.Size()>0){
        
          }
            
    }
    public void newUser(){
    
    
    }
}