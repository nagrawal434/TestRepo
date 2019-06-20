public class ContactDetailList{
    public List<ModelClass> modelList{get;set;} 
    public String selectLimit{get;set;}
    public ContactDetailList(){
        modelList = new List<ModelClass>();
        for(contact c : [select id,lastname,photourl,firstname,phone,email,birthdate from contact]){
            ModelClass obj = new ModelClass();
            obj.contact = c;
            modelList.add(obj);
        }
    
    }
    public List<selectOption> getlimitSize(){
        List<selectOption> selectList = new List<selectOption>();
        selectList.add(new selectOption(string.valueOf(1),'one'));
        selectList.add(new selectOption(string.valueOf(2),'two'));
        selectList.add(new selectOption(string.valueOf(5),'five'));
        selectList.add(new selectOption(String.valueOf(25),'twentyfive'));
        selectList.add(new selectOption(string.valueOf(50),'fifty'));
        selectList.add(new selectOption(String.valueOf(100),'hundred'));
        return selectList;  
    }
    public Class ModelClass{
    public Contact contact{get;set;}
    public ModelClass(){
        contact = new Contact();    
    }
    } 
}