public class DisplayReport{
    public DisplayReport(){
        
        Report contactReportObj = [SELECT Id,Name From Report  LIMIT 1];
        String reportURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + contactReportObj.Id;        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('DiscoverOrg - Append & Clean');        
        string body = 'This email is to inform you that your DiscoverOrg Append & Clean job for Contacts just completed:\n';              
        //body += processingRecords + ' Contacts sent for processing\n';
        //body +=   updatedCountByDoId + ' Contacts matched with a DiscoverOrg ID';   
        //body += 'To review Leads matched with a DiscoverOrg ID view the' ;
        body += '<a href="' + reportURL + '">click</a>';     
        mail.setHtmlBody(body);
        mail.setToAddresses(new string[] {'nagrawal434@gmail.com'});                    
        try {           
            Messaging.sendEmail(new Messaging.Email[] {mail});                       
        } catch (exception ex) {
            System.debug('==539=='+ex.getMessage());
        }
    } 
}