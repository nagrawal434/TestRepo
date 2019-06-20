public class listsetController{
    public list<String> strls{get;set;}
    public listsetController()
    {
        strls= new list<String>();
        strls.add('India');
        strls.add('Rajsthan');
        strls.add('Ajmer');
        strls.add('USA');
        system.debug('##'+strls.size());
        for(String i: strls){
        system.debug(i);
        }
        Map<Integer,String> m1=new Map<Integer,String>();
        m1.put(1,'India');
        m1.put(2,'Rajsthan');
        m1.put(3,'Ajmer');
        system.debug(m1);
    }
}