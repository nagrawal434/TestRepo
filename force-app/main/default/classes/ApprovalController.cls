public class ApprovalController{
    public String status{get;set;}
    
    public ApprovalController (){
        //submitAndProcessApprovalRequest();
    }
    
    public void submitAndProcessApprovalRequest() {
        // Insert an account
        Account a = new Account(Name='Diksha Sharma',annualRevenue=100.0, billingCity='Jaipur',shippingCity='Ajmer');
        insert a;
           
        User user1 = [SELECT Id FROM User WHERE Name='Neha Agrawal'];    
        try{
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setComments('Automatic submit');
            req1.setObjectId(a.id); // object at which approval process will be started
            req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});//Approver ID
            Approval.ProcessResult result = Approval.process(req1);
            status = result.getInstanceStatus();
            system.debug('******************'+result);                      
        }Catch(Exception e){
            System.debug('Error while creating approval request:' + e.getMessage());
        }                
    }
}