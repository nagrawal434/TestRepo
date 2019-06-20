public class uploadCSVOnPagecontroller1{
    public Blob contentFile{get;set;}
    public String nameFile {get;set;}
    public Integer rowCount{get;set;}
    public Integer colCount { get; set; }
    public Map<String,List<String>> ForMatchEmailMap;
    public Set<List<String>> getResults(){
        Set<List<String>> parsedCSV = new Set<List<String>>();
        rowCount = 0;
        colCount = 0;
        if(contentFile != null){
            String fileString = contentFile.toString();
            parsedCSV = parseCSV(fileString,False);
            rowCount = parsedCSV.size();
            for (List<String> row : parsedCSV){
                if (row.size() > colCount){
                    colCount = row.size();
                }
            }
         }
        return parsedCSV;
      }
     public static Set<List<String>> parseCSV(String contents,Boolean skipHeaders)
     {
        Set<List<String>> allFields = new Set<List<String>>();
        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try
        {
          lines = contents.split('\r'); 
        }
        catch(System.ListException e)
        {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        Integer num = 0;
        for(String line: lines)
        {
           if(line.replaceAll(',','').trim().length() == 0) break;
            List<String> fields = line.split(',');
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field: fields)
            {
                if (field.startsWith('"') && field.endsWith('"'))
               {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
                else if (field.startsWith('"'))
                {
                    makeCompositeField = true;
                    compositeField = field;
                }
                else if (field.endsWith('"'))
                {
                  compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                }
               else if (makeCompositeField)
                {
                   compositeField +=  ',' + field;
                }
               else
                {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
                       
                       System.debug('@@' + cleanFields);
                       allFields.add(cleanFields);
        }
        return allFields;      
     }
}