public class XmlCallApiController{
    private xmldom theXMLDom;
    public list<contactModel> contactModels{get;set;}
    //Constructor
    public XmlCallApiController(){
        contactModels = new List<contactModel>();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://contactedit-developer-edition.ap2.force.com/XMLAssignment');
        req.setMethod('GET');
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String xml = res.getBody();
        theXMLDom = new  xmldom(xml);
        parse();
        // insertContact();
        
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
                    cm.email= elmInnerChild.nodeValue;
                }
            }
            contactModels.add(cm);
        }
    }
   /* public void insertContact();
    {
            
    
    
    
    } */
    public class ContactModel{
        public String firstname{get;set;}
        public String lastname{get;set;}
        public String email{get;set;}
     }
}