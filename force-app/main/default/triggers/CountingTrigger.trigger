trigger CountingTrigger on Contact (after update){
     if(Trigger.isInsert && Trigger.isAfter){
        List<Contact> cList = new List<Contact>();
            Integer count;
            for(Contact obj : Trigger.new)
            {
                 Contact c = Trigger.oldMap.get(obj.id);
                  
                 if(Trigger.Size>0)
                 {
                    count++;
                
                    obj.Counting__c = String.valueOf(count);
                }
            } 
           for(Contact c : [select firstname  from contact]){
            c.firstname ='ddd';
            cList.add(c);
           }  
           if(cList .size() > 0)
           update cList;
    }
}