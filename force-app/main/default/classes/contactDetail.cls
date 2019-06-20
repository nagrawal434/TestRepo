/*
    Name : Neha Agrawal
    Date : 2/5/2016
    Author : 
    Description : Contact Insert;
*/
public class contactDetail{
    public List<Contact> conList{get;set;}
    public List<ModelClass> modelList{get;set;}
    public Set<String> idSet;
    public Map<String,String> contactIdAttachMap; 
    public contactDetail(){
        conList = new List<Contact>();
        idSet = new Set<String>();
        conList = [Select id,name,email,phone from Contact limit 9];
        contactIdAttachMap = new Map<String,String>(); 
        modelList = new List<ModelClass>();
        for(Contact c: conList){
            idSet.add(c.id);    
        }
        Document defaultimg = [select id from Document Where name = 'DefaultImagepic'];
        for(Attachment a : [select id,name,parentId from Attachment Where parentId IN: idSet]){
            contactIdAttachMap.put(a.parentId,a.id);
        } 
        System.debug('@@@' +contactIdAttachMap);   
        for(Contact con : conList){
            ModelClass obj = new ModelClass();
            obj.contact = con;
            if(contactIdAttachMap.get(con.id) == null){
                obj.imageURL = obj.imageURL+ defaultimg.id;     
            }else{
                obj.imageURL = obj.imageURL+ contactIdAttachMap.get(con.id); 
            }
            modelList.add(obj);
        }
        System.debug('#####' +modelList);           
    }       
    public Class ModelClass{
        public Contact contact{get;set;}
        public String imageURL{get;set;}            
        public ModelClass(){
            contact = new Contact();
            imageURL='/servlet/servlet.FileDownload?file=';
        }
    } 
}