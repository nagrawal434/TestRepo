trigger firstnamerequiredFirstName2 on Contact (before insert){
    if(Trigger.isInsert)
        {
            for(Contact c: Trigger.new)
            {
               if(c.firstname ==null)
                {
                     c.firstname.addError('Field is Required');
                }
            }
        
        }
        






}