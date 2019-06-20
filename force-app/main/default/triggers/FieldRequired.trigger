trigger FieldRequired on Contact (after insert) {
    if(Trigger.isInsert && Trigger.isAfter){
        List<contact> con = new List<Contact>();
        Set<String> ids = new Set<String>();
        for(Contact obj : Trigger.new){
           if(obj.firstname == null){
               ids.add(obj.id);
             }
        }
        for(Contact c : [select firstname  from contact where id in:ids]){
            c.firstname ='ddd';
            con.add(c);
        }
        if(con.size() > 0)
            update con;
    }
}