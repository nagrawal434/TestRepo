public class ModelClassDemoControllerForTest{
   
      public List<ModelClass> models{get;set;}
      public ModelClassDemoControllerForTest(){
            models = new List<ModelClass>();
            for(contact c : [select id,firstname,accountid from contact]){
                ModelClass obj = new ModelClass();
                obj.con = c;
                models.add(obj);
            }
      }
        public class ModelClass{
           public contact con{get;set;}
           
        }
        
}