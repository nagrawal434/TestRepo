public class ObjectListController{
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public Boolean pbs1{get;set;}
    public Boolean pbs2{get;set;}
    public String selectedObject{get;set;}
    public String selectedField{get;set;}
    public List<ModelClass> modelList{get;set;}
    public Integer rowIndex{get;set;}
    public List<selectOption> fields{get;set;}
    private set<String> fieldsSet{get;set;}
    public Map<String,String> fieldTypeMap{get;set;}
    public ObjectListController(){
        pbs1 = true;
        pbs2 = false;
        fieldTypeMap = new Map<String,String>();
        fieldsSet = new set<String>();
         modelList = new List<ModelClass>();
    }
    public List<SelectOption> getObjectName(){
         List<SelectOption> objNames = new List<SelectOption>();
         List<String> entities = new List<String>(schemaMap.keySet()); 
         entities.sort();
         List<Schema.DescribeSObjectResult> describeSobjectsResult = Schema.describeSObjects(entities);
         for(Schema.DescribeSObjectResult name : describeSobjectsResult)
            {
                if(name.isAccessible() && name.isUpdateable() && name.isCreateable())
                {
                objNames.add(new SelectOption(name.getName(),name.getLabel()));
                }
            }
         
        return objNames;
     }
     public void fieldRecord(){
         pbs2 = true;
         modelList = new List<ModelClass>();
         fields = new List<selectoption>();
         map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
         if(describe.containsKey(selectedObject))
         {
             Schema.SObjectType ObjectSchema = schemaMap.get(selectedObject);            
             Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap();       
             for(String fieldName : fieldMap.KeySet()){
                 Schema.SObjectField field = fieldMap.get(fieldName);
                 String fldType = String.valueOf(field.getDescribe().getType());
                 String fldLabel = field.getDescribe().getname();
                 fieldTypeMap.put(fieldName,fldType);
                 Schema.DescribeFieldResult F = field.getDescribe(); 
                 Boolean isFieldreq  = F.isNillable();
                 List<selectOption> requiredOpt = new List<selectOption>();
                 if(isFieldreq  == false && F.isupdateable() && F.isCreateable())
                 {
                    
                     if( fieldname != 'ownerid' && fieldname != 'contacted__c')
                     { 
                      
                       if(!fieldsSet.contains(fieldName))
                       {
                           requiredOpt.add(new selectoption(fieldname,fieldname));
                           
                       }
                       ModelClass objname = new ModelClass(requiredOpt,modelList.size());     
                       system.debug('***' +modelList.size()); 
                       objname.fieldType = String.valueOf(fldType);
                       objname.displayList = true;
                       objname.currentField = fieldName; 
                       modelList.add(objname);
                       fieldsSet.add(fieldName);
                    }
              }
              }
              // system.debug('@@' +modelList);
          }
      }
    public void fieldType(){
       system.debug('###' +rowIndex); 
       if(modelList[rowIndex].currentField!= '--None--'){
            fieldsSet.clear();
            for(ModelClass mod : modelList)
                fieldsSet.add(mod.currentfield);
            map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
            String dataType = String.ValueOf(describe.get(selectedObject).getdescribe().fields.getmap().get(modelList[rowIndex].currentfield).getDescribe().getType());
            modelList[rowIndex].fieldType = dataType;
        }else{
            modelList[rowIndex].fieldType = '';
        }
     }
     public void addRow()
      {
            List<selectOption> allFields = new  List<selectOption>();
            map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
            if(describe.containsKey(selectedObject)) 
            {
               Schema.SObjectType ObjectSchema = schemaMap.get(selectedObject);   
               Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap();
                allFields.add(new selectOption('','Select'));
               for(String fieldname : fieldMap.keySet())
               {
                  Schema.SObjectField field = fieldMap.get(fieldName);
                  String fldLabel = field.getDescribe().getLabel();
                 if(!fieldsSet.contains(fieldname))
                 { 
                  allFields.add(new selectOption(fieldname,fldLabel));
                 }   
               }  
                ModelClass obj2 = new ModelClass(allFields,modelList.size());
                modelList.add(obj2);
            }
      }
      public void nextPage(){
      }
     public class ModelClass{
          public String fieldType{get;set;}
          public List<SelectOption> requireFields{get;set;}
          public Integer count{get;set;}
          public String inputDegaultReq{get;set;}
          public Boolean displayList{get;set;}
          public String fieldLabel{get;set;}
          public String currentField{get;set;}
          public ModelClass(List<SelectOption> requireFields,Integer count)
          {
              this.requireFields = requireFields;
              this.count= count;           
              displayList = false;
          }
        } 
     
     
     
     
     
     
}