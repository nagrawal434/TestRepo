public class ExportController{
    public String reportId{get;set;}
    public String selectedEncoding{get;set;}
    public String selectedFormat{get;set;}
    public String reportName{get;set;}
    public ExportController(){
        selectedEncoding = 'GB18030';
        selectedFormat = 'xls';
        reportId = ApexPages.currentPage().getParameters().get('id');
        reportName = [Select id,name from Report where id = :reportId].name;                               
    }
    public List<SelectOption> getEncodings() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('ISO-8859-1','ISO-8859-1 (General US &amp; Western European, ISO-LATIN-1)'));
        options.add(new SelectOption('Unicode','Unicode'));
        options.add(new SelectOption('UTF-8','Unicode (UTF-8)'));
        options.add(new SelectOption('MS932','Japanese (Windows)'));
        options.add(new SelectOption('Shift_JIS','Japanese (Shift-JIS)'));
        options.add(new SelectOption('GB18030','Chinese National Standard (GB18030)'));
        options.add(new SelectOption('GB2312','Chinese Simplified (GB2312)'));
        options.add(new SelectOption('Big5','Chinese Traditional (Big5)'));
        options.add(new SelectOption('EUC_KR','Korean'));
        options.add(new SelectOption('UTF-16','Unicode (UTF-16, Big Endian)'));
        options.add(new SelectOption('Big5-HKSCS','Big5 Traditional Chinese (HKSCS)'));
        options.add(new SelectOption('x-SJIS_0213','Japanese (Shift_JIS-2004)'));
        return options;
   }
   public List<SelectOption> getTypes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('xls','Excel Format .xls'));
        options.add(new SelectOption('localecsv','Comma Delimited .csv'));
        return options;
   }
   public void exportMethod(){
        
   }
   public PageReference doneMethod(){
        PageReference nextPage = new PageReference('/' + reportId);
        return nextPage; 
   } 
}