public class ContactSearch{
    public ContactSearch(){
    
    }
    public static List<Contact> searchForContacts(String firststring,String SecondString){
        List<Contact> conList = new List<Contact>();
        conList = [select id,name from contact Where lastname = :firststring AND MailingPostalCode = :secondString];
        return conList;
    }
}