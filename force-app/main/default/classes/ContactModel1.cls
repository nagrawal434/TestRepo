public class ContactModel1{
    public Integer i=1;
    public Boolean isSelected=false;
    public List<seriesModelClass>seriesList{get;set;}
    public list<Contact> selectedList{get;set;}
    public ContactModel1(){
            seriesList = new List<seriesModelClass>();
            selectedList= new list<Contact>();
        for(Contact c: [Select FirstName, LastName, Phone, Email from Contact where email!=null]){
            seriesModelClass smod = new seriesModelClass();
            smod.con=c;
            smod.sno=i++;
            smod.isSelected=false;
            seriesList.add(smod);
        }
    }
        public pageReference deleteFun(){
            for(seriesModelClass st :seriesList){
            

                      if(st.isSelected){
                    selectedList.add(st.con);
                }
            }
            
        try{
            if(selectedList.size() == 0){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Select Any Record');
                ApexPages.addMessage(myMsg);
                return null;        
            }else{
                delete selectedList;
                return new PageReference('/apex/ContactModel1Page').setRedirect(true);
            }
        }         
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Invalid DML Operation.');
            ApexPages.addMessage(myMsg);
            return null;
        }
       }
    
    public class seriesModelClass{
    public Contact con {get;set;}
    public Integer sno{get;set;}
    public Boolean isSelected{get;set;}
        public seriesModelClass(){
            con= new Contact();
            sno=0;
        }
    }
}