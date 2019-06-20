public class UploadCsFileController{
    public Blob csvFileBody{get;set;}
    public String filename{get;set;}
    public string csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    public List<ModelClass> ModeldataList{get;set;}
    public UploadCsFileController(){
        csvFileLines = new String[]{};
    }
    public void dispalyDataMethod(){
           filename =blobToString(csvFileBody,'ISO-8859-1');
           ModeldataList = new List<ModelClass>(); 
           csvFileLines = filename.split('\n'); 
           for(Integer i=1;i<csvFileLines.size();i++){
               String[] inputvalues = new String[]{};
               inputvalues = csvFileLines[i].split(',');
               ModelClass modelObj = new ModelClass();
               modelObj.data = inputvalues[i];
               ModeldataList.add(modelObj);
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
        public String data{get;set;}
        public ModelClass(){
        } 
    }
}