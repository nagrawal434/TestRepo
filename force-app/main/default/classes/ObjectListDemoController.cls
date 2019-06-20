public class ObjectListDemoController
{
    public Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public String selectedObject{get; set;}
    public ObjectListDemoController(){
        selectedObject = 'account';        
    
    
    
    }
    public List<SelectOption> getObjectNames() 
    {
        List<SelectOption> objNames = new List<SelectOption>();
        List<String> entities = new List<String>(schemaMap.keySet());
        entities.sort();
        for(String name : entities)
        {
            objNames.add(new SelectOption(name,name));
        }
        return objNames;
     }












}