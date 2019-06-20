public class ObjectRecordInsertController{
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();    
    public String selectedObject {get; set;}
    public String selectedField {get; set;}
    public Set<String> selectedFieldSet;
    public Integer selectedIndex {get; set;}
    public List<ModelClassObject> ObjectModelList{get;set;}
    public ModelClassObject ObjModel{get;set;}
    public Integer i=0;
    public Boolean pbs1 {get;set;}
    public Boolean pbs2 {get;set;}
    public Boolean pbs3 {get;set;}
    public string objname{get;set;}
    public Map<String,Schema.DisplayType> fieldTypeMap;
    public ModelClassObject ObjectModel = new ModelClassObject();
    public Set<String> insertValueSet{get;set;}
    public List<ModelClassBulkRecord> BulkRecordSaveList{get;set;}
    public List<sObject> sObjList{get;set;}
    public String txtValue {get;set;}
    public ObjectRecordInsertController(){   
        ObjectModelList = new List<ModelClassObject>();    
        fieldTypeMap = new Map<String,Schema.DisplayType>();   
        selectedFieldSet = new Set<String>();
        sObjList = new List<sObject>();
        pbs1=true;
        pbs2=true;
        pbs3=false;
    }
    public List<SelectOption> getObjectNames(){
        List<SelectOption> objNames = new List<SelectOption>();    
        List<String> entities = new List<String>(schemaMap.keySet());
        entities.sort();       
        for(String name : entities){
           Schema.SObjectType obj =  schemaMap.get(name);
           if(obj.getDescribe().isCreateable()){
               objNames.add(new SelectOption(name,name));
           }
        } 
        return objNames;
     }
     public void TableRecord(){
        ObjectModelList = new List<ModelClassObject>();
        i=0;
        Schema.SObjectType ObjectSchema = schemaMap.get(selectedObject);            
        Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap();            
        for(String fieldName : fieldMap.keySet())
        {                 
            ObjectModel = new ModelClassObject();                
            Schema.SObjectField field = fieldMap.get(fieldName);
            Schema.DisplayType fldType = field.getDescribe().getType();
            //String fldLabel = field.getDescribe().getLabel();
            String fldLabel = field.getDescribe().getname();
            fieldTypeMap.put(fieldName,fldType); // Map Of Fields Type
            Schema.DescribeFieldResult F = field.getDescribe();         
            if(fieldName != 'ownerid'){
            if(!F.isNillable() && F.isAccessible() && F.isUpdateable()){    
                ObjectModel.Sno = ++i;   
                ObjectModel.fieldLabel = fldLabel;  
                ObjectModel.reqFieldNames.add(new SelectOption(fieldName,fieldName));                    
                ObjectModel.reqfieldType = fieldType(fieldName);  
                //ObjectModel.fieldValue = txtValue;
                ObjectModel.displayField=true;
                ObjectModelList.add(ObjectModel);          
            }
            }
        }
       // NewRow();
     }     
     public void NewRow(){           
           selectedFieldSet.add(selectedField);
           ObjectModel = new ModelClassObject();
           ObjectModel.Sno = ++i;           
           Schema.SObjectType ObjectSchema = schemaMap.get(selectedObject);            
           Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap();            
           ObjectModel.reqFieldNames.add(new SelectOption('','----Select----'));
           for(String fieldName : fieldMap.keySet())
            {    
                if(!selectedFieldSet.contains(fieldName)){             
                        Schema.SObjectField field = fieldMap.get(fieldName);
                        Schema.DisplayType fldType = field.getDescribe().getType();   
                        Schema.DescribeFieldResult F = field.getDescribe();  
                        if(F.isNillable() && F.isAccessible() && F.isUpdateable()){
                            ObjectModel.reqFieldNames.add(new SelectOption(fieldName,fieldName)); 
                        }                 
                }   
           }  
           ObjectModel.displayField=false;        
           ObjectModelList.add(ObjectModel);
     }
     public Schema.DisplayType fieldType(String selField){
         String sField = selField;
         Schema.DisplayType selFieldtype = fieldTypeMap.get(sField);    
         return selFieldtype;
     }
     public void dynamicFieldType(){
         Schema.DisplayType selectedFieldType = fieldType(selectedField);
         ModelClassObject selectedFieldRecord = new ModelClassObject();
         for(ModelClassObject obj : ObjectModelList){
             if(obj.Sno == selectedIndex){                 
                 selectedFieldRecord.Sno = i;
                 String fldLabel = schemaMap.get(selectedObject).getDescribe().fields.getMap().get(selectedField).getDescribe().getname();
                 //String fldLabel = schemaMap.get(selectedObject).getDescribe().fields.getMap().get(selectedField).getDescribe().getLabel();
                 selectedFieldRecord.fieldLabel = fldLabel; 
                 selectedFieldRecord.reqFieldNames.add(new SelectOption(selectedField,selectedField));
                 selectedFieldRecord.reqfieldType = selectedFieldType;                 
                 selectedFieldRecord.displayField=false;
             }
         }    
        for (Integer i = (ObjectModelList.size()-1) ; i>= 0 ; i--){
            ModelClassObject om = ObjectModelList[i];
            if(om.Sno == selectedIndex){
                ObjectModelList.remove(i);
            }
        } 
        ObjectModelList.add(selectedFieldRecord);
     }
     public pageReference saveBulkRecord(){
        insert sObjList; 
        return new PageReference('/apex/ObjectRecordInsertPage').setRedirect(true);       
     }
     public void NextPage(){
         sObject dynObject = Schema.getGlobalDescribe().get(selectedObject).newSObject();
         system.debug('%%%drt' + dynObject);
         for(ModelClassObject moc : ObjectModelList){
            dynObject.put(moc.fieldLabel,moc.fieldValue);
       }
       sObjList.add(dynObject);
        pbs1=false;
        pbs2=false;
        pbs3=true;
     }
     public void addRow(){
         sObject dynObject = Schema.getGlobalDescribe().get(selectedObject).newSObject();
        for(ModelClassObject moc : ObjectModelList){
            dynObject.put(moc.fieldLabel , moc.fieldValue);
        }
        sObjList.add(dynObject);
     }
     public class ModelClassObject{
         public Integer Sno{get;set;}
         public String fieldLabel{get;set;}
         public List<SelectOption> reqFieldNames{get;set;}
         public Schema.DisplayType reqFieldType{get; set;}
         public String fieldValue{get;set;} 
         public Boolean displayField{get;set;}        
         public ModelClassObject(){
             reqFieldNames = new List<SelectOption>();
         }
     }
     public class ModelClassBulkRecord{
             public String bulkFieldLabel{get;set;}
             public String bulkFieldValue{get;set;}
     }
}