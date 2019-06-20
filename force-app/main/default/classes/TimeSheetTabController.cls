/*
    Name : Neha Agrawal
    Author : 
    Date : 1/2/2016
    Description : 'TabVfPAgeTimeSheet'

*/
public class TimeSheetTabController{
    public List<ModelClass> candidateList{get;set;}
    public Date[] dates{get;set;}
    public Map<String,Decimal> CantactNameDateMap{get;set;}
    public Set<String> IdSet;
    public CandidateTimeSheet__c  contactInsert{get;set;}
    public Map<Date,String> mapSunColor{get;set;}
    public List<decimal> totalSum{get;set;}
    public String SelectedContact{get;set;}
    public Integer selectYear{get;set;}
    public Integer selectMonth{get;set;}
    public TimeSheetTabController(){
        CantactNameDateMap = new Map<String,Decimal>();
        IdSet = new Set<String>();
        selectYear = Date.Today().Year();
        selectMonth = Date.Today().Month();
        displayTimeSheet();
    }    
        public void displayTimeSheet(){             
            contactInsert = new CandidateTimeSheet__c();  
            candidateList = new List<ModelClass>();
            totalSum = new List<decimal>(); 
            mapSunColor = new Map<Date,String>();   
            for(CandidateTimeSheet__c c : [Select id,resourcename__c,ResourceName__r.name,Date__c,hours__c from CandidateTimeSheet__c]){ 
                IdSet.add(c.resourcename__c);
                CantactNameDateMap.put(c.ResourceName__r.name +'/'+ c.Date__c,c.hours__c);
            }           
            dates = new Date[] {};
            Integer daysInMonth = Date.daysInMonth(selectYear, selectMonth );
            for (Integer day = 1; day <= daysInMonth; day++){
                dates.add(Date.newInstance(selectYear, selectMonth , day));
            } 
            for(Date dtc : dates){
                if(dtc.toStartOfWeek() == dtc){
                    mapSunColor.put(dtc,'#ffff1a');
                }
                else{
                    mapSunColor.put(dtc,'#ffe680');    
                }    
            }
            Map<Date,Decimal> mapTotal = new Map<Date,Decimal>();
            List<AggregateResult> newList = [Select sum(hours__c) total,date__c from CandidateTimeSheet__c group by date__c];
            for(AggregateResult agg : newList){
               mapTotal.put((Date)agg.get('date__c'),(Decimal)agg.get('total'));
            }
            for(Date dte : dates){
               if(mapTotal.get(dte) != null){
                       totalSum.add((Integer)mapTotal.get(dte));
               }
               else{
                   totalSum.add(0);
               } 
            }
            for(Contact c : [Select id,name from Contact where id IN: IdSet]){
                ModelClass obj2 = new ModelClass();
                obj2.candidate= c.name;
                for(Date dt : dates){
                    colorWrapper ObjColorModel = new colorWrapper(); 
                    if(CantactNameDateMap.get(c.name +'/'+ dt) != null){
                        ObjColorModel.hour = (CantactNameDateMap.get(c.name +'/'+dt));
                         
                    }
                    else{
                            ObjColorModel.hour=0;
                    }
                    if(dt.toStartOfWeek() == dt){
                        system.debug('innnnn'+dt);
                        ObjColorModel.colorcolumn = '#ffff00';    
                    } 
                    else{
                         if(ObjColorModel.hour !=0){
                             ObjColorModel.colorcolumn = ' #ffffe5';
                         }
                         else{
                             ObjColorModel.colorcolumn = '#ff704d';
                         }  
                    }   
                    obj2.ColorHour.add(ObjColorModel);    
                } 
                candidateList.add(obj2); 
             }
        }
    public List<selectOption> getContactList(){
        List<selectOption> conList = new List<selectOption>();
        for(Contact c : [Select id,name from contact]){
            conList.add(new SelectOption(c.id,c.name));
        }
        return conList;
    }
    public pageReference save(){
        List<CandidateTimeSheet__c> newCandidateList = [Select id,resourceName__c,date__c,hours__c from candidateTimesheet__c Where resourceName__c =: SelectedContact And date__c =: contactInsert.date__c]; 
        contactInsert.ResourceName__c = SelectedContact;         
        if(newCandidateList.size() == 0){
            insert contactInsert; 
        }
        else{
            contactInsert.id = newCandidateList[0].id;
            upsert contactInsert;
        }
            return new PageReference('/apex/TimeSheetTabPage').setRedirect(True);         
    }
    public List<selectOption> getmonthList(){
        List<selectOption> mList = new List<selectOption>();
        mList.add(new selectOption('1','JAN'));
        mList.add(new selectOption('2','FEB'));
        mList.add(new selectOption('3','MAR'));
        mList.add(new selectOption('4','APR'));
        mList.add(new selectOption('5','MAY'));
        mList.add(new selectOption('6','JUN'));
        mList.add(new selectOption('7','JULY'));
        mList.add(new selectOption('8','AUG'));
        mList.add(new selectOption('9','SPT'));
        mList.add(new selectOption('10','OCT'));
        mList.add(new selectOption('11','NOV'));
        mList.add(new selectOption('12','DEC'));
        return mList;
    }
    public List<selectOption> getYearList(){
        List<selectOption> yList = new List<selectOption>();
        for(Integer y =2000; y <= 2016; y++){
            yList.add(new selectOption(String.valueOf(y),String.valueOf(y)));
        } 
        return yList;
    }
    public class ModelClass{
        public String candidate{get;set;}
        public Map<Date,Boolean> ColorMap{get;set;}
        public List<colorWrapper> ColorHour{get;set;}
        public ModelClass(){
            ColorMap = new Map<Date,Boolean>(); 
            ColorHour= new List<colorWrapper>(); 
        } 
    }
    public class colorWrapper{
        public String colorcolumn{get;set;}
        public Decimal hour{get;set;}
        public Decimal totalSum{get;set;}
        public colorWrapper(){
        }
    }
}