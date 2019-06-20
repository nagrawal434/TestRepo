public class NewCaseListController{
    public NewCaseListController(){
    
    }
    public List<Case> getNewCases(){
        List<Case> caseList = new List<Case>();
        caseList = [Select id,CaseNumber from case Where status = :'New'];
        System.debug('%%' +caseList);
        return caseList;
    }
}