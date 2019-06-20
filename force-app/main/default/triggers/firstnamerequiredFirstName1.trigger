trigger firstnamerequiredFirstName1 on Contact (before insert) {
    if(Trigger.isInsert)
        {
            for(Contact c: Trigger.new)
            {
                Integer len = c.firstname.Length(); 
                if(len<2)
                {
                    c.firstname.addError('Name should be greater than three');
                }
                
            }
        
        }
        
    }