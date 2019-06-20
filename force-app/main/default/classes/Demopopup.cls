public class Demopopup
{    
    public boolean displayPopup {get; set;}    
   
    public void closePopup()
    {       
        System.debug('@@@');
       
        displayPopup = false;   
    }    
    public void showPopup()
    {       
        System.debug('#####');
        displayPopup = true;   
    }   
  }