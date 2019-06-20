public class XmlDormContactSiteController{
   public List<Contact> conList{get;set;}
   public List<ContactModel> contactModels{get;set;} 
   public List<String> xmlContactRecordList {get;set;}
   public String xmlContactRecord {get;set;}
   private xmldom theXMLDom ;
   public XmlDormContactSiteController(){
       conList = new List<Contact>();
       xmlContactRecordList = new List<String>();
       contactModels = new List<ContactModel>();
       conList =[Select id,firstname,lastname,email from Contact];
         for(Contact c : conList)
           { 
            xmlContactRecord =    '<contacts>' +
                                            '<contact>' + '<firstname>'+c.firstname+'</firstname>' +
                                                          '<lastname>'+c.lastname+'</lastname>' +
                                                          '<email>'+c.email+'</email>' +
                                            '</contact>' +
                                        '</contacts>';
             xmlContactRecordList.add(xmlContactRecord);
          }
          system.debug('@@@@' +xmlContactRecordList); 
         for(String s : xmlContactRecordList)
         {
             theXMLDom = new  xmldom(s);
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
}
}