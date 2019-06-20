public class WrapperClassDemo
{
    public List<WrapperClass> lstWrap{get;set;}
    public List<Contact> conList{get;set;}
    public contact conInsert{get;set;}
    public String status{get;set;}
    
    
    public WrapperClassDemo(){
        Integer i= 0;
        conInsert = new contact() ;
        lstWrap = new List<WrapperClass>();
        
        for(Contact lWrap : [SELECT id,name FROM Contact]){
            WrapperClass wrapObj = new WrapperClass();
            wrapObj.s_no = i++;
            wrapObj.con = lWrap;
            wrapObj.flag = false;
            lstWrap.add(wrapObj);
        }
    }
    
    //Function to check wheather checkbox is checked or not..
    
    public void check(){
        system.debug('@@@@');
        for(WrapperClass lsW : lstWrap){
            if(status == lsW.con.id)
            {
                lsW.flag=true;
            }
        }
        //system.debug('@@@@' + conList);
    }
    
    //Save record
    
    public pageReference saveRecord(){
        conList = new List<Contact>();
        try{
            for(WrapperClass lsWrap : lstWrap){
                if(lsWrap.flag==true){
                    conList.add(lsWrap.con);
                }
            }
           
           if(conList.size() >0){
               system.debug('#### ' + conList);
               upsert conList;
           }
        }catch(Exception ex){
            system.debug('******** ' + ex);
        }
        return new PageReference('/apex/WrapperClassDemoPage').setRedirect(true);
    }
   
    
    //Insert Contact..
    
    public PageReference insertContact(){
        List<Contact> lstInsert;
        lstInsert = new List<Contact>();
       
        lstInsert.add(conInsert);
        if(lstInsert.size()>0)
        {
            insert lstInsert;
        }
        return new PageReference('/apex/WrapperClassDemoPage').setRedirect(true);
        //insert conInsert;
    }
    
    //Wrapper Class..
    
    public class WrapperClass{
        public Integer s_no{get;set;}
        public Contact con {get;set;}
        public boolean flag{get;set;}
    }
}