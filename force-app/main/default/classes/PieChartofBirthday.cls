public with sharing class PieChartofBirthday{
    public Integer fromMonth{get;set;}
    public Integer toMonth{get;set;}
    public Integer fromYear{get;set;}
    public Integer toYear{get;set;}
    public Map<String,Integer> contactMap;
    public Map<Integer,Integer> contactAgeMap;
    public Map<String,Integer> AgeMap;
    public Integer i;
    public Integer j;
    public Integer k;
    public Integer l;
    public Integer m;
    public Integer total;
    public List<wrapperClass> wrapperList{get;set;}
    public List<Wrapperclass2> wrapperList2{get;set;}
    public Map<Integer,String> monthMap;
    public pageReference searchMethod(){
        contactMap = new Map<String,Integer>();
        contactAgeMap = new Map<Integer,Integer>();
        monthMap= new Map<Integer,String>(); 
        AgeMap= new Map<String,Integer>();  
        wrapperList = new List<wrapperClass>();
        wrapperList2= new List<Wrapperclass2>(); 
        i= 1;
        j=1;
        k=0;
        l=0;
        m=0;
        Date startDate= Date.newinstance(fromYear,fromMonth,1);
        Date endDate=   Date.newinstance(toYear,toMonth,30);
        for(Integer mnth=1; mnth<=12;mnth++){
            if(mnth== 1)
            monthMap.put(mnth,'Jan');
            if(mnth== 2)
            monthMap.put(mnth,'Feb');
            if(mnth== 3)
            monthMap.put(mnth,'March');
            if(mnth== 4)
            monthMap.put(mnth,'Aprl');
            if(mnth== 5)
            monthMap.put(mnth,'May');
            if(mnth== 6)
            monthMap.put(mnth,'June');
            if(mnth== 7)
            monthMap.put(mnth,'July');
            if(mnth== 8)
            monthMap.put(mnth,'Aug');
            if(mnth== 9)
            monthMap.put(mnth,'Sep');
            if(mnth== 10)
            monthMap.put(mnth,'Oct');
            if(mnth== 11)
            monthMap.put(mnth,'Nov');
            if(mnth== 12)
            monthMap.put(mnth,'Dec');
        }       
        for(Contact con: [Select id,birthdate,name from Contact]){
            if(con.birthdate != null){
                if(!contactMap.containsKey(String.valueOf(con.birthdate.year()) + String.valueOf(con.birthdate.month()))){
                    contactMap.put(String.valueOf(con.birthdate.year()) + String.valueOf(con.birthdate.month()),i);
                }
                else{
                    Integer jcount= contactMap.get(String.valueOf(con.birthdate.year()) + String.valueOf(con.birthdate.month()));
                    jcount = jcount+1;
                    contactMap.put(String.valueOf(con.birthdate.year()) + String.valueOf(con.birthdate.month()),jcount);
                } 
              
            }
                     
        }       
        while(startDate <= endDate){      
            if(startDate.year() !=  endDate.year()){
                Wrapperclass2 obj2= new Wrapperclass2();
                Integer countNo = contactMap.get(String.valueOf(startDate.year()) + String.valueOf(startDate.month()));
                wrapperClass obj = new wrapperClass();             
                
                //DateTime dt= DateTime.newInstance(startDate,Time.newInstance(0,0,0,0));
                //String monthDemo = dt.format('MMMM');           
                obj.dataXasies = String.valueOf(startDate.year()) +','+ monthMap.get(startDate.month()) ;
                if(countNo == null){
                 obj.countYaxies = 0;
                } 
                else{ 
                    if(!contactAgeMap.containsKey(startDate.year())){
                        total=countNo;
                        contactAgeMap.put(startDate.year(),countNo);
                    }else{
                        total= total+countNo;
                        contactAgeMap.put(startDate.year(),total);
                    }
                    obj.countYaxies = countNo;
                }   
                 wrapperList.add(obj);      
            }
            else if(startDate.month() <= endDate.month()){    
                    wrapperClass obj = new wrapperClass();
                    Integer countNo = contactMap.get(String.valueOf(startDate.year()) + String.valueOf(startDate.month()));     
                    //DateTime dt= DateTime.newInstance(startDate,Time.newInstance(0,0,0,0));
                    //String monthDemo = dt.format('MMMM');
                    obj.dataXasies = String.valueOf(startDate.year()) +','+ monthMap.get(startDate.month());
                    if(countNo == null)
                        obj.countYaxies= 0;
                    else{
                        if(!contactAgeMap.containsKey(startDate.year())){
                            total=countNo;
                            contactAgeMap.put(startDate.year(),countNo);
                        }else{
                            total= total+countNo;
                            contactAgeMap.put(startDate.year(),total);
                        }
                        obj.countYaxies = countNo;
                    }         
                    wrapperList.add(obj);
             }
            startDate = startDate.addMonths(1);     
        }  
        for(Integer yearAge: contactAgeMap.keySet()){
            Integer calculatedAge= Date.Today().Year() - yearAge;
            Integer cntAge= contactAgeMap.get(yearAge);
            if(calculatedAge <= 18){
                k = k+cntAge;                
                AgeMap.put('Child',k);       
            }else if(calculatedAge <= 35){
                l = l+cntAge;
                AgeMap.put('Adult',l); 
            }else{
                m = m+cntAge;
                AgeMap.put('Citizen',m);
            }
        }
        for(String str: AgeMap.KeySet()){
            Wrapperclass2 obj= new Wrapperclass2(); 
            if(str== 'Child'){
                obj.PersonCategory= str;
                obj.countPerson= AgeMap.get('Child'); 
            } 
            if(str== 'Adult'){
                obj.PersonCategory= str;
                obj.countPerson= AgeMap.get('Adult');    
            }
            if(str== 'Citizen'){
                obj.PersonCategory= str;
                obj.countPerson= AgeMap.get('Citizen');    
            }
            wrapperList2.add(obj);              
        }         
        return new pageReference('/apex/PieChartofBirthdayPage');
    }                                 
    //Wrapper Class
    public class wrapperClass{
        public Integer countYaxies{get;set;}
        public String dataXasies{get;set;} 
        public wrapperClass(){
        
        } 
    }
    //Wrapper Class
    public class Wrapperclass2{
        public Integer countPerson{get;set;}
        public String PersonCategory{get;set;}
    }
}