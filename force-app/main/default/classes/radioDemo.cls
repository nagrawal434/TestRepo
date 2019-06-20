public class radioDemo{
    public List<Contact> conList{get;set;}
    public radioDemo(){
        conList = new List<Contact>();
        conList = [Select id,Firstname,Lastname,email from Contact limit 5];
        
    } 
    public void selectcon(){
        System.debug('$$$$');
        String selid = System.currentPagereference().getParameters().get('conid');
        System.debug('*******' +selid );
    }
}