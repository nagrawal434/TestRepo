public class NewObjectAssignment{
    public Integer currentIndex{get;set;}
    public string currentobject{get; set;}
    public Boolean flag{get;set;}
    public Boolean pgb{get;set;}
    public List<selectoption> fields{get;set;}
    public List<String> fetchRequired{get;set;}
    public List<ModelClassObject> modelList{get;set;}
    public List<SObject> objList{get;set;}
    private set<string> selectedFields;
    public NewObjectAssignment(){
        objList = new List<SObject>();
        modelList = new List<ModelClassObject>();
        currentIndex = 0;
        pgb = false;
        selectedFields = new set<string>();
    }
    public selectoption[] getobjects() {
        selectoption[] objects = new selectoption[0];
        map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
        for(string objectname:describe.keyset()) {
            objects.add(new selectoption(objectname,describe.get(objectname).getdescribe().getname()));
        }
        flag = true;
        return objects;
    }
    public void fetchFields() {
        modelList = new List<ModelClassObject>();
        fields = new List<selectoption>();
        map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
        if(describe.containskey(currentobject)) {
            map<string,schema.sobjectfield> fieldmap = describe.get(currentobject).getdescribe().fields.getmap();
            for(string fieldname : fieldmap.keyset()){
                fields.add(new selectoption(fieldname,fieldmap.get(fieldname).getdescribe().getlabel()));
                Schema.DisplayType fielddataType = fieldMap.get(fieldName).getDescribe().getType();
                Schema.DescribeFieldResult F = fieldmap.get(fieldname).getdescribe();
                Boolean req  = F.isNillable();
                if(req == false && (fieldmap.get(fieldname).getdescribe().isUpdateable()) && (fieldmap.get(fieldname).getdescribe().isCreateable())){
                    List<selectOption> requiredOpt = new List<selectOption>();
                    if(fieldname != 'ownerid' && fieldname != 'contacted__c'){
                        if(!selectedFields.contains(fieldname)){
                            requiredOpt.add(new selectoption(fieldname,fieldmap.get(fieldname).getdescribe().getlabel()));
                        }
                        ModelClassObject moc = new ModelClassObject(requiredOpt, modelList.size());
                        moc.isReq = true;
                        moc.currentfield = fieldname;
                        moc.type = String.ValueOf(fielddataType);
                        modelList.add(moc);
                        selectedFields.add(fieldname);
                    }
                }
            }
        }
    }
    public class ModelClassObject{
        public Integer rowid{get;set;}
        public string currentfield {get; set;}
        public String value{get;set;}
        public String type{get;set;}
        public List<SelectOption> fName{get;set;}
        public boolean isReq{get;set;}
        public ModelClassObject(List<SelectOption> fname, Integer rowid){
            this.rowid = rowid;
            this.fName = fname;
            isReq = false;
        }
    }
    public void add(){
        List<SelectOption> fields1 = new List<SelectOption>();
        map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
        if(describe.containskey(currentobject)){
            map<string,schema.sobjectfield> fieldmap = describe.get(currentobject).getdescribe().fields.getmap();
            for(string fieldname : fieldmap.keyset()){
                if(!selectedFields.contains(fieldname)){
                    fields1.add(new selectoption(fieldname,fieldmap.get(fieldname).getdescribe().getlabel()));                    
                }
            }
            ModelClassObject moc = new ModelClassObject(fields1, modelList.size());
            modelList.add(moc); 
        }
    }
    public void fieldType(){
        if(modelList[currentIndex].currentfield != '--None--'){
            selectedFields.clear();
            for(ModelClassObject mod : modelList)
                selectedFields.add(mod.currentfield);
                
            map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
            String dataType = String.ValueOf(describe.get(currentobject).getdescribe().fields.getmap().get(modelList[currentIndex].currentfield).getDescribe().getType());
            modelList[currentIndex].type = dataType;
        }else{
            modelList[currentIndex].type = '';
        }
    }
    public void next(){
        pgb = true;
        sObject dynObject = Schema.getGlobalDescribe().get(currentobject).newSObject();
        for(ModelClassObject moc : modelList){
            dynObject.put(moc.currentfield , moc.value);
        }
        objList.add(dynObject);
    }
    public void addRow(){
        sObject dynObject = Schema.getGlobalDescribe().get(currentobject).newSObject();
        for(ModelClassObject moc : modelList){
            dynObject.put(moc.currentfield , moc.value);
        }
        objList.add(dynObject);
    }
    public PageReference Save(){
        /*
        sObject dynObject = Schema.getGlobalDescribe().get(currentobject).newSObject();
        String query = 'Select id from ' + dynObject ;
        dynObject = Database.Query(query);
        Id did = dynObject.id;
        String str = String.valueOf(did);
        String uid = str.substring(0,2);
        system.debug('final data' + did ;*/
        insert objList;
        PageReference pg = new PageReference('/apex/NewObjectAssignmentPage').setRedirect(true);
        return pg;
        
    }
}