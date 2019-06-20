@isTest
public Class ModelClassTest1{
    @isTest
    public static void ModelClassTestMethod(){
        
        Contact cont = new Contact(lastname = 'dd');
        insert cont;
        ModelClassDemoController obj1 = new ModelClassDemoController();
        obj1.conId = cont.id;
       
    
    } 
}