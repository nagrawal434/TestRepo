global class myHandler implements Messaging.InboundEmailHandler{

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    Messaging.InboundEmail.BinaryAttachment[] tAttachments = email.binaryAttachments; // // Since Attachment is CSV we are taking as BinaryAttachments. 
    list<Contact> lstContact = new list<Contact>(); // list of accounts.
    String csvbody='';
    
    list<list<String>> allFields = new list<list<String>>(); // list of rows in csv
    list<String> lines = new list<String>(); // Rows of CSV
    list<String> headers = new list<String>(); // Field names   
    list<String> fields = new list<String>(); // list of fields 
    
    if(tAttachments !=null){
        for(Messaging.InboundEmail.BinaryAttachment btt : tAttachments){
            if(btt.filename.endsWith('.csv')){
                csvbody = btt.body.toString();//Take the blob body of the CSV binary attachment and extract it to a string object, then process it.
                try {
                    // Replace instances where a double quote begins a field containing a comma    
                    // In this case you get a double quote followed by a doubled double quote    
                    // Do this for beginning and end of a field 
                    csvbody = csvbody.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
                    // now replace all remaining double quotes - we do this so that we can reconstruct    
                    // fields with commas inside assuming they begin and end with a double quote 
                    csvbody = csvbody.replaceAll('""','DBLQT');
                    lines = csvbody.split('\n');
                }catch (System.listException e){
                    System.debug('Limits exceeded?' + e.getMessage());
                }
            }
        }
        
        integer rowNumber = 0;
        
        for(String line : lines) {
        // check for blank CSV lines (only commas) 
            if (line.replaceAll(',','').trim().length() == 0) break;
                fields = line.split(',', -1);
                allFields.add(fields);
                if(rowNumber == 0){
                    // for getting the field names. 
                    for(list<String> rows : allFields){    
                        for(String header : rows){
                            headers.add(String.valueof(header.trim()));
                        }   
                    break;
                    }
                
                    rowNumber++;
                    continue;
                }
            }       
            for(Integer i = 1 ; i < lines.size() ; i++){
                Contact con = new Contact();
                con.put(headers[0] , allFields[i][0]);
                con.put(headers[1] , allFields[i][1]);
                con.put(headers[2] , allFields[i][2]);
                con.put(headers[3] , allFields[i][3]);
                lstContact.add(con);
            }
            insert lstContact;
        }
        return result;
    }
}