public class AddDelConRowController 
{
    public List<Contact> conAddList{get;set;}
    public String memberName {get;set;} 
    public Integer rowIndex{get;set;}
    public Contact del; 
    public List<Contact> delcontactList{get;set;} 
    public AddDelConRowController()
    {
        delcontactList = new List<Contact>();
        conAddList = new List<Contact>();
        conAddList.add(new Contact());
        conAddList.add(new Contact());
        conAddList.add(new Contact());
    }
    public void addRow()
    {
        conAddList.add(new Contact());
    } 
    public void deleteRow(){
        rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
        System.debug('rowbe deleted ' + rowIndex );
        del = conAddList.remove(rowIndex);
    } 
    public pageReference saveRecord(){
        List<Contact> newRecordList = new List<Contact>();
        for(Contact s: conAddList){
            if((s.firstname == null || s.firstname == '') && (s.lastname == null || s.lastname == '') && (s.Father_Name__c == null || s.father_name__c == '') && (s.DetailFee__c == null || s.detailfee__c == '')){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Fill Row Or Deleted Blank Row');
                ApexPages.addMessage(myMsg);
            return null;           
            }else{
                newRecordList.add(s);
            }
        }
        if(newRecordList.size() > 0){
            insert newRecordList;
        }
      return new pageReference('/apex/NewAddRowPage').setRedirect(True); 
    }
}