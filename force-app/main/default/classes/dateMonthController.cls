public class dateMonthController{
    public Contact contact;
    public dateMonthController(){
        contact = new Contact();
        contact = [select id,name,birthdate from contact where name = 'Neha Agrawal' limit 1];
        
    }
}