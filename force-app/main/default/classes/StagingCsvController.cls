public class StagingCsvController{
    public Blob inputFileBolb{get;set;}
    public String inputFileString;
    public String[] csvFileLines;
    public List<Staging__c> stageList;
    public StagingCsvController(){
    }
    public pageReference insertCSV(){
        csvFileLines = new String[]{};
        stageList = new List<Staging__c>();
            /*if(inputFileBolb == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please Add CSV File'));
                return null;
            }*/
            
                inputFileString = blobToString(inputFileBolb,'ISO-8859-1');
                csvFileLines = inputFileString.split('\n'); 
                for(Integer i=1;i<csvFileLines.size();i++){
                    Staging__c stageObj =new Staging__c(); 
                    string[] csvRecordData = csvFileLines[i].split(',');
                    stageObj.First_Name__c = csvRecordData[0];
                    stageObj.Last_Name__c = csvRecordData[1];
                    stageObj.phone__c= csvRecordData[2];
                    stageObj.Email__c= csvRecordData[3];
                    stageList.add(stageObj);
                
                if(stageList.size() > 0){
                    insert  stageList;
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Record Created Successfully.Thank you!'));
                }                    
                //return null;
            } 
            return null;      
    } 
     public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }       
}