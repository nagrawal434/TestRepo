public class OpportunityInformationPage{
    public opportunity oppstring{get; set;}
    public String oName{get;set;}
    public OpportunityContactRole contactRoleDetail{get;set;}
    public List<Opportunity> oppList{get;set;}
    public Contact con{get;set;}
    public String EmptyContact{get;set;}
    public List<OpportunityContactRole> selectContactRoleList{get;set;} 
    public List<ModelClass> ModelList{get;set;}
    public List<ModelClass> OppConRoleModelList{get;set;}
    public List<Opportunity> OppRecordList{get;set;}
    public OpportunityInformationPage()
    {
        oppstring= new opportunity();
        con = new Contact();
        contactRoleDetail = new OpportunityContactRole();
        OppConRoleModelList = new List<ModelClass>();
        ModelList = new List<ModelClass>(); 
        oppList = new List<opportunity>();
        OppRecordList = new List<opportunity>();
        oppList  = [select id,Owner.name from Opportunity];
        for(opportunity o : oppList){
            oName = o.owner.name;
        }
        if(ModelList.isEmpty()){
             EmptyContact = 'No Contact Role';   
        }
        
        
    }
    public void add(){
            
   }
   public void ContactRecordAdd(){       
       String  ContactId = contactRoleDetail.ContactId;
       EmptyContact = '';
       for(Contact c : [Select id,name from Contact Where id = :ContactId]){
           ModelClass ModelObj = new ModelClass();
           ModelObj.RoleContact = c.name; 
           system.debug('@@' + ModelObj.RoleContact);
           ModelObj.RoleName = contactRoleDetail.Role;
           ModelList.add(ModelObj);        
       }    
  }
  public void Save(){
  
  }
  public void addAllOppCon(){
      Opportunity OppObj = new Opportunity();
    // opp.AccountId = oppstring.Accountid;
      
      
                  
  }
  public void cancel(){
  }
  public class ModelClass{
      public String RoleContact{get;set;}
      public String RoleName{get;set;}
      public opportunity OppDetail{get;set;}
      public String RoleContactList{get;set;}
      public ModelClass(){
          OppDetail = new  opportunity();
      }
  }

}