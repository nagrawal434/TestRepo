public class PaginationContactController{
    public List<Contact> conList{get;set;}
    public Integer count;
    public List<Contact> newConList;
    public List<Contact> contactList{get;set;}
    public Map<Integer,List<Contact>> conactCountMap;
    public integer newVar; 
    public Integer no;
    public Boolean prevShow{get;set;}
    public Boolean nxtShow{get;set;}
    public PaginationContactController(){
        conList = new List<Contact>();
        newConList = new List<Contact>();
        newVar = 1;
        no = 0;
        conactCountMap = new Map<Integer,List<Contact>>();        
        conList = [select id,firstname,lastname,email from contact]; 
        count = 20;
        fetchRecord();         
    }
    public void fetchRecord(){      
        for(Integer i = 0; i < conList.size()-1; i++){    
            newConList.add(conList[i]);
            if(newConList.size() == count){
                ++no;
                conactCountMap.put(no,newConList);  
                newConList = new List<Contact>();                  
            }                                                                          
        }
        if(newConList.size() > 0){
            ++no;
            conactCountMap.put(no,newConList);     
        } 
        show();
    }
    public void show(){
        contactList = new List<Contact>();
        if(conactCountMap.get(newVar)!= null){
            for(Contact ct : conactCountMap.get(newVar)){
            contactList.add(ct);
            }
        }
    }
    public Boolean getPre(){
        if(newVar == 1){
            return true;
        }else{
            return false;
        }
    }
    public Boolean getNxt(){
        
        return false;
    }
    
    public void prev(){
        newVar = newVar-1;
        show();
        System.debug('&&&&&&&&&&' +newVar);        
    }
    public void next(){
        newVar = newVar+1;
        show();
        System.debug('&&&&&&&&&&' +newVar);                    
    } 
}