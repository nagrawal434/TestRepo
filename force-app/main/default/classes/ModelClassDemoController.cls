public class ModelClassDemoController{
      public String conId{get;set;}
      public List<ModelClass> models{get;set;}
      public ModelClassDemoController(){
            models = new List<ModelClass>();
            for(contact c : [select id,name,accountid from contact]){
                ModelClass obj = new ModelClass();
                obj.sno = models.size()+1;
                obj.con = c;
                models.add(obj);
            }
           
        }
        public class ModelClass{
            public integer sno{get;set;}
            public contact con{get;set;}
           
        }
        
}