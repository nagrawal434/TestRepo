public Class XmlParseController{   
    private xmldom theXMLDom;
    String wsa = 'http://schemas.xmlsoap.org/ws/2004/08/addressing';
    public XmlParseController(){ 
        String xmlString=
        '<atom:entry xmlns:atom="http://www.w3.org/2005/Atom" xmlns:gd="http://schemas.google.com/g/2005">' + 
            '<atom:category scheme="http://schema"/>' +
            '<atom:title>' + 'Full Name1234' + '</atom:title>' +
            '<gd:name>' +
                '<gd:givenName>' + 'CODE123' + '</gd:givenName>' +
                '<gd:familyName>' + 'Last23' + '</gd:familyName>' +
            '</gd:name>' +
            '<gd:structuredPostalAddress rel="http://schemas.google.com/g/2005#work" primary="true">' + 
            '<gd:city>' + 'CITY' + '</gd:city>' +
            '<gd:street>' + 'STREET' + '</gd:street>' +
            '<gd:region>' + 'REGION' + '</gd:region>' +
            '<gd:postcode>' + 'POSTCODE' + '</gd:postcode>' +
            '<gd:country>' + 'COUNTRY' + '</gd:country>' +
            '</gd:structuredPostalAddress>' +
            '<gd:formattedAddress>' +
                'CITY STREET REGION POSTCODE COUNTRY' +
            '</gd:formattedAddress>' +
            '<gd:phoneNumber rel="http://schemas.google.com/g/2005#home" primary="true">' +
                '874859652245' +
            '</gd:phoneNumber>' +
            '<gd:email label="Home" address="test@test.com" displayName="" />' +
        '</atom:entry>' ;
        theXMLDom = new  xmldom(xmlString);
        List<xmldom.Element> elementStructList = theXMLDom.getElementsByTagName('entry');
        List<xmldom.Element> nameelementStructList = theXMLDom.getElementsByTagName('name'); 
        for(xmldom.Element element :elementStructList){
            list<xmldom.Element> childNodeList1 = element.childNodes;
            String userEmail = '';
            for(xmldom.Element innrElement : element.childNodes){
                list<xmldom.Element> childNodeList = innrElement.childNodes;
                if(innrElement.nodeName.toLowerCase() == 'email'){
                    userEmail =  innrElement.getAttribute('address');    
                } 
            }
            System.debug('DDDD' +userEmail);
        }
    }
}