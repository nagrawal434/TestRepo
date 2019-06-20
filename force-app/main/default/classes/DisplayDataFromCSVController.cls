public class DisplayDataFromCSVController{
    public Blob csvFileBody{get;set;}
    public String[] csvFileLines{get;set;}
    public string nameFile{get;set;}
    public List<ModelClass> ModelConObjList{get;set;}
    public Set<String> MatchEmail{get;set;}
    public Set<String> MatchEmailSetPage{get;set;}
    public DisplayDataFromCSVController(){
    csvFileLines = new String[]{};
    MatchEmailSetPage = new Set<String>();
    }
    public void importCSVFile(){
           MatchEmail = new Set<String>(); 
           System.debug('#####' +csvFileBody);
           nameFile =blobToString(csvFileBody,'ISO-8859-1');
           System.debug('@@@@' +nameFile);
           ModelConObjList = new List<ModelClass>(); 
           csvFileLines = nameFile.split('\n'); 
           for(Integer i=1;i<csvFileLines.size();i++){
               ModelClass conObj = new ModelClass() ;
               string[] csvRecordData = csvFileLines[i].split(',');
               System.debug('%%%%%%%' +csvRecordData[0]);
               conObj.ModelConObj.firstname = csvRecordData[0] ;             
               conObj.ModelConObj.lastname= csvRecordData[1];
               conObj.ModelConObj.phone= csvRecordData[2];
               conObj.ModelConObj.email= csvRecordData[3];
               if(MatchEmail.contains(csvRecordData[3])){
                   MatchEmailSetPage.add(csvRecordData[3]);
                   conObj.color = 'red';
                   system.debug('@@@' +MatchEmailSetPage);    
                   system.debug('**' + conObj.color);

               }
               MatchEmail.add(csvRecordData[3]);
               ModelConObjList.add(conObj);   
          }
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
    public class ModelClass{
        public Contact ModelConObj{get;set;}
        public String color{get;set;}
        public ModelClass(){
            ModelConObj = new Contact();
        } 
    }
    
}