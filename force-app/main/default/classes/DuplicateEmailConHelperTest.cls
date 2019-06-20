@isTest
public class DuplicateEmailConHelperTest{
    static testMethod void methodTest(){
     
        
        
        Test.startTest(); //Starts the scope of test
        Set<String> emailSet = new Set<String>();
        // Create Data For Contact Object
        emailSet.add('a@gmail.com');
        Contact con1 = new Contact(firstname = 'af',lastname = 'al',email = 'a@gmail.com',phone = '123');
        
        
        //Now, our trigger will fire on before insert event so update the Records
        insert con1;
      
        //Now, our trigger will fire on before update event so update the Records
        //con1.email =  'b@gmail.com';
        update con1;
        
        Test.stopTest();
    }
}