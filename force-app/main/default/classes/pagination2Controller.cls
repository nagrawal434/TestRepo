public class pagination2Controller{
    public Integer pageNo{get;set;}
    private integer perPage = 10;
    public Boolean isSendMail{get;set;}
    public List<List<Contact>> modalList; 
    public pagination2Controller(){
        pageNo = 0;
        modalList = new List<List<Contact>>();
    }

    public List<List<Contact>> getinvoiceList(){
          
        List<Contact> invList = new List<Contact>();
        List<Contact> invModalList = new List<Contact>();
        
        for(Contact con : [select id,Name,Email,Phone,Account.name from Contact]){
            invModalList.add(con);
        }
        decimal totalPages = 0;
        Integer no = 1;
        if(invModalList.size() > 0){
            totalPages = math.ceil(invModalList.size() / perPage);
        }
        
        for(Contact obj: invModalList){
            invList.add(obj);
            if(math.mod(no, perPage) == 0 ){
                modalList.add(invList);
                invList = new List<Contact>();
            }
            if(totalPages == modalList.size() && invList.size() < perPage && invList.size() != 0){
                modalList.add(invList);
            }
            no=no+1;
        }
        return modalList;
    }
    public void sendMailMethod(){
        for(List<Contact> con : modalList){
            /*System.debug('****' +con.Name);
            System.debug('****' +isSendMail); */
        }    
    }
}