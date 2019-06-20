public class XMLAssignmentController{
    public List<Contact> contactList{get;set;}
    public List<String> xmlList;
    private xmldom theXMLDom;
    public list<contactModel> contactModels{get;set;}
    //Constructor
    public XMLAssignmentController(){
        contactList = new List<Contact>();
        contactModels = new List<contactModel>();
        xmlList = new List<String>();
        contactList = [Select firstname, lastname, email From Contact];
        for(Contact con : contactList){
        String xmlRecord;
        xmlRecord = '<contacts>' +
                    '<contact>' +
                        '<firstname>'+con.firstname+'</firstname>' +
                        '<lastname>'+con.lastname+'</lastname>' +
                        '<email>'+con.email+'</email>' +
                    '</contact>' +                    
                '</contacts>';
        xmlList.add(xmlRecord); 
        }               
        for(String xml : xmlList){
            theXMLDom = new  xmldom(xml); 
            parse();
        }
        
    } 
    public void parse(){
        List<xmldom.Element> elementStructList = theXMLDom.getElementsByTagName('contact');
        for(xmldom.Element element : elementStructList){
            ContactModel cm = new ContactModel();
            for(xmldom.Element elmInnerChild: element.childNodes){
                if(elmInnerChild.nodeName.toLowerCase() =='firstname'){
                    cm.firstname= elmInnerChild.nodeValue;
                }else if(elmInnerChild.nodeName.toLowerCase() =='lastname'){
                    cm.lastname= elmInnerChild.nodeValue;
                }else if(elmInnerChild.nodeName.toLowerCase() =='email'){
                    cm.email = elmInnerChild.nodeValue;
                }
            }
            contactModels.add(cm);
        }
    }
    public class ContactModel{
        public String firstname{get;set;}
        public String lastname{get;set;}
        public String email {get;set;}
     /*   public ContactModel(String name , String phone , String email){
            this.name = name ;
            this.phone = phone ;
            this.email = email; 
        } */
    }
}