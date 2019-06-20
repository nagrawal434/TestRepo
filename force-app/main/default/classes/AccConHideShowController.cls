public class AccConHideShowController{
    public list<modelclassAcc> modelListAcc{get;set;}
    public list<modelclassCon> modelListCon{get;set;}
    public integer indxacc{get;set;}
    public integer indxcon{get;set;}
    public integer indxval{get;set;}
    public AccConHideShowController(){
        modelclassAcc accClass=new modelclassAcc();
        modelListAcc = new list<modelclassAcc>(); 
        accClass.acc=new Account();
        accClass.indexAcc=modelListAcc.size();

        //modelclassCon conClass=new modelclassCon();
        accClass.conList =new list<modelclassCon>();
      
        //conclass.indexcon=accClass.conList.size();
        //accClass.conlist.add(conClass); 
         modelListAcc.add(accClass);
       
    }
    public class modelclassAcc{
        public Account acc{get;set;} 
        public integer indexAcc{get;set;}
        public list<modelclassCon> conList{get;set;}
        
        
    }
    public class modelclassCon{
        public Contact con{get;set;} 
        public integer indexCon{get;set;}
    }
    public void addAccount(){
         modelclassAcc accClass=new modelclassAcc();
       
        accClass.acc=new Account();
        accClass.indexAcc=modelListAcc.size();

        //modelclassCon conClass=new modelclassCon();
        accClass.conList =new list<modelclassCon>();
        
        //conclass.indexcon=accClass.conList.size();
        //accClass.conlist.add(conClass); 
         modelListAcc.add(accClass);     
    }
     public void removeAccount(){
         modelListAcc.remove(indxacc);
         integer i=0;
         for(modelClassAcc m:modelListacc){
             m.indexAcc=i;
             i++;
         }    
    }
    public void addcontact(){
        modelclassCon conClass=new modelclassCon();
        modelclassAcc accClass=new modelclassAcc();
        system.debug('*********'+indxcon);
        
        for(modelclassAcc a:modellistacc){
            system.debug('********'+a.indexacc);
            if(indxval==a.indexacc){
                conClass.con=new contact();
                conClass.indexcon=a.conlist.size();  
                a.conlist.add(conClass);
            }
       }    
    }
     public void removecontact(){
         system.debug(indxval+' %%%%% index '+ indxcon);
         for(modelclassacc m:modellistacc){
             if(indxval==m.indexacc){
               m.conlist.remove(indxcon);
             }
           
         integer i=0;
         for(modelclasscon c:m.conlist){
             c.indexcon=i;
             i++;
          }   
         }
    } 
    public pagereference save(){
        try{
            String errorMsg='';
            list<account> accList1=new list<account>();
            for(modelclassacc m: modellistacc){
                acclist1.add(m.acc);
            }
            
            insert accList1;
            list<Contact> conList1=new list<Contact>();
            contact con1=new contact();
            for(integer i=0;i<modellistacc.size();i++){
                    system.debug('********'+modellistacc[i].conlist);
                   for(modelclasscon gh:modellistacc[i].conlist){
                        gh.con.accountId=accList1[i].id;
                        con1=gh.con;
                        conlist1.add(con1);
                   } 
             }
             insert conList1;
             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Records Saved Successfully.'));
             
             modelclassAcc accClass=new modelclassAcc();
             modelListAcc = new list<modelclassAcc>(); 
             accClass.acc=new Account();
            accClass.indexAcc=modelListAcc.size();
    
            accClass.conList =new list<modelclassCon>();
          
             modelListAcc.add(accClass);
             return null;
             
         }catch(exception e){
             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
             return null;
         }
         
        
         
     }
    public void deleteAll(){
      modellistacc.clear();   
    }
}