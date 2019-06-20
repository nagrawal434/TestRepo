public with sharing class Graph
{  
    public List<PieWedgeData> getPieData() 
    {  
        List<PieWedgeData> data = new List<PieWedgeData>();
        List<Member__c> memb = new List<Member__c>();  
        
        String sql = 'SELECT Name, Year_s_Of_Experience__c FROM Member__c';
        memb = Database.Query(sql);
        for(Member__c temp:memb)
        {           
            data.add(new PieWedgeData(temp.Name,temp.Year_s_Of_Experience__c));
        }
        return data;  
    }  
    
    // Wrapper class  
    public class PieWedgeData 
    {  
        public String name { get; set; }  
        public Decimal data { get; set; }  
        
        public PieWedgeData(String name, Decimal data) 
        {  
            this.name = name;  
            this.data = data;  
        }  
    }  
}