public Class AccountParentChildController{
    
    public List<ModelClass> modelList{get;set;}
    public Account acc{get;set;}
    public String SearchString{get;set;}
    public String accountId;
    public AccountParentChildController(ApexPages.StandardController controller){
        modelList= new List<ModelClass>(); 
        accountId= ApexPages.currentPage().getParameters().get('Id');
        acc= [SELECT id,name,(SELECT id,firstname,lastname,email,phone from Contacts) from ACCOUNT Where id= :accountId];
        integer i=0;
        for(CONTACT con: acc.Contacts){
            ModelClass modelobj= new ModelClass();
            modelobj.contactChild= con;
            modelobj.Chk= false;
            modelobj.serialNumber= ++i;
            modelList.add(modelobj);                  
        }
                        
    }
    public Void searchContact(){
        modelList = new List<ModelClass>(); 
        String search= '%' + SearchString + '%';
        integer i=0;
        List<Contact> conList= [SELECT id,firstname,lastname,email,phone,name from Contact WHERE (lastname LIKE :search or firstname LIKE :search or name LIKE :search)  and accountId= :accountId];
        for(Contact con: conList){
            ModelClass obj= new ModelClass();
            obj.contactChild= con; 
            obj.Chk= false;
            obj.serialNumber= ++i;
            modelList.add(obj);
        }
    }
    public PageReference EditContacts(){
        Set<id> contactIds= new Set<id>();  
        for(ModelClass obj :modelList){
            if(obj.Chk== true){
                contactIds.add(obj.contactChild.id);
            }
        }
        System.debug('$$$$$$$$$' +contactIds);
        
        
        return new PageReference('/apex/LightningFormEdit?id=' +contactIds).setRedirect(true);
    }
    public class ModelClass{
        public Contact contactChild{get;set;}
        public Boolean Chk{get;set;}
        public Integer serialNumber{get;set;}
        public ModelClass(){
            contactChild= new Contact();
        } 
    } 
}