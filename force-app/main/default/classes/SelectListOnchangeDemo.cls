public class SelectListOnchangeDemo
{
    public String temp {get; set;}
    public String temp1 {get; set;}

    public SelectListOnchangeDemo() 
    {

    } 
    
    public void find()
    {
        if(temp == 'a')
        {
            temp1 = 'Welcome';
        }
        else if(temp == 'b')
        {
            temp1 = 'Thank you';
        }
    }            
}