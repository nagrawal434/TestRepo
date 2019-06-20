public class PieChartDemoController {
 
    // Data wrapper class
    public class Data {
        public String name { get; set; }
        public Integer clicks { get; set; }
        
    }
 
    // Our data points
    public List<Data> dataPoints {get;set;}
 
    // Controller sets three buttons to 0 clicks
    public PieChartDemoController (){
        dataPoints = new List<Data>();
        button1();
        button2();
        button3();
    }
 
    // Button 1 clicked
    public PageReference button1() {
         Data dt1 = new Data();
         dt1.clicks = 5;
     
         dt1.name = 'Click 1';
         dataPoints.add(dt1);
         return null;
    }
 
    // Button 2 clicked
    public PageReference button2() {
         Data dt1 = new Data();
         dt1.clicks = 40;
       
         dt1.name = 'Click 2';
         dataPoints.add(dt1);
         return null;
    }
 
    // Button 3 clicked
    public PageReference button3() {
         Data dt1 = new Data();
         dt1.clicks = 25;
     
         dt1.name = 'Click 3';
         dataPoints.add(dt1);
         return null;
    }
 
}