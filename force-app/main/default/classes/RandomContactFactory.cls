public Class RandomContactFactory{
    public static List<Contact> generateRandomContacts(Integer a,String b){
        
        List<Contact> conList = new List<Contact>();
        for(Integer i= 0; i<a ; i++){
            Contact con = new Contact(firstName = 'Test' + i,lastName = b);
            conList.add(con);
        }
        return conList;
    }
}