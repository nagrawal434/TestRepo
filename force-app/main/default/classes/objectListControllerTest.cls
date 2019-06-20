public class objectListControllerTest
{
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public String selectedObject{get;set;}
    public Integer currentFieldCount{get;set;}
    public Integer val{get;set;}
    public List<ModelFieldType> objfieldtypereturn{get;set;}
    public String currentFieldValue{get;set;}
    public Boolean pbs1 {get;set;}
    public Boolean pbs2 {get;set;}
    public Boolean pbs3 {get;set;}
    public List<sObject> sObjList{get;set;}
    public Map<String,Schema.DisplayType> fieldTypeMap{get;set;}
    Public objectListControllerTest()
    {  
        selectedObject = 'account';
        fieldTypeMap = new Map<String,Schema.DisplayType>(); 
        sObjList = new List<sObject>();
        pbs1=true;
        pbs2=true;
        pbs3=false;
   }
    public List<SelectOption> getObjectNames() 
    {
        List<SelectOption> objNames = new List<SelectOption>();
        List<String> entities = new List<String>(schemaMap.keySet());
        entities.sort();
        List<Schema.DescribeSObjectResult> describeSobjectsResult = Schema.describeSObjects(entities);
        objNames.add(new SelectOption('','--None--'));
         for(Schema.DescribeSObjectResult name : describeSobjectsResult)
            {
                if(name.isAccessible() && name.isUpdateable() && name.isCreateable())
                {
                objNames.add(new SelectOption(name.getName(),name.getLabel()));
                }
            }
        return objNames;
     }
     public void objfieldtype(){
             objfieldtypereturn = new List<ModelFieldType>();
             val = 0;
             Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
             Schema.SObjectType ObjectSchema = schemaMap.get(selectedObject);
             Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap();
             for(Schema.SObjectField allField : fieldMap.Values()){
                 Schema.DescribeFieldResult f = allField.getDescribe();
                 ModelFieldType objname = new ModelFieldType();
                 String fieldname = f.getName();
                 Schema.DisplayType fieldType = f.getType();
                 fieldTypeMap.put(fieldname,fieldType);
                 system.debug('****' +fieldTypeMap);
                 Boolean isFieldreq  = !f.isNillable() && f.isupdateable();
                 if(isFieldreq && f.getName() != 'ownerid')
                 {
                    objname.count = ++val;
                    objname.ftype = string.valueOf(f.getType());
                    objname.displayList = true;
                    objname.fieldLabel = f.getName();
                    objname.fname.add(new SelectOption(f.getName(),f.getLabel()));
                    objfieldtypereturn.add(objname);
                 }
              }
      }
      public void addRow(){
          for(ModelFieldType t : objfieldtypereturn) {
              system.debug('********@@@'+t.ftype);
          }
      
      
             ModelFieldType objname = new ModelFieldType();
             objname.count = ++val;
             Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
             Schema.SObjectType ObjectSchema = schemaMap.get(selectedObject);
             Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap();   
             objname.fname.add(new SelectOption('','--None--'));
             for(Schema.SObjectField allField : fieldMap.Values()){
                    Schema.DescribeFieldResult f = allField.getDescribe();
                    Boolean isFieldreq  = f.isNillable();
                    if(isFieldreq  == true)
                    {
                        objname.fname.add(new SelectOption(f.getName(),f.getLabel())); 
                        objname.ftype = string.valueOf(f.getType());
                        //objname.ftype = string.valueOf(fieldTypeMap.get(f.getName()));                
                   }
             }
             objfieldtypereturn.add(objname);
        }
        public void fieldType(){
                ModelFieldType obj2  = new ModelFieldType();
                system.debug('@@@@@@******====' +currentFieldCount); 
                
                for(ModelFieldType m : objfieldtypereturn)
                {
                     system.debug('@@@@@@******' + m.ftype); 
                     if(m.count == currentFieldCount)
                     {
                          m.ftype  =  string.valueOf(fieldTypeMap.get(currentFieldValue));
                          m.fname.add(new SelectOption(currentFieldValue,currentFieldValue));
                          obj2  = m;
                          break;
                     }
              }
             
               system.debug('@@@@ objfieldtypereturn ******* ' + objfieldtypereturn); 
     }
       public void save(){
        
        }
        public class ModelFieldType{
          public string ftype{get;set;}
          public List<SelectOption>  fname{get;set;}
          public Integer count{get;set;}
          public String inputDegaultReq{get;set;}
          public Boolean displayList{get;set;}
          public String selectedField {get;set;}
          public String fieldLabel{get;set;}
          public ModelFieldType()
          {
              fname = new List<SelectOption>();           
              displayList = false;
          }
        }
}