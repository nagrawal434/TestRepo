public Class AccCon{
    public List<Contact> con;
    public AccCon(){
        con = new List<Contact>();
        con = [Select accountid,id,account.name,account.BillingAddress from contact]; 
        System.debug('@@@'+con);
    
    
    }



}