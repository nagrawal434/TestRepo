public class JSONParserController{
    public List<ModelClass> modelList{get;set;}
    public JSONParserController(){
        try{
            String jsonString = '[ {"results" : [{"address_components" : [{"long_name" : "Balupura Road","short_name" : "Balupura Rd","types" : [ "route" ]},{ "long_name" : "Ajmer","short_name" : "Ajmer","types" : [ "locality",{"long_name" : "Ajmer","short_name" : "Ajmer","types" : [ "administrative_area_level_2", "political" ]},{"long_name" : "Rajasthan","short_name" : "RJ","types" : [ "administrative_area_level_1", "political" ]},{"long_name" : "India","short_name" : "IN","types" : [ "country", "political" ]},{"long_name": "305002","short_name" : "305002","types" : [ "postal_code" ]}],"formatted_address" : "Balupura Rd, Ajmer, Rajasthan 305002, India","geometry" : {"bounds" : {"northeast" : {"lat" : 26.4243642,"lng" : 74.6586526},"southwest" : {"lat" : 26.4231465,"lng" : 74.65098210000001}},"location" : {"lat" : 26.4240048,"lng" : 74.6549205},"location_type" : "GEOMETRIC_CENTER","viewport" : {"northeast" : {"lat" : 26.42510433029151,"lng" : 74.6586526},"southwest" : {"lat" : 26.4224063697085,"lng" : 74.65098210000001}}},"partial_match" : true,"place_id" : "ChIJcXnZKjLhazkRp8wcETEjCh4","types" : [ "route" ]}],"status" : "OK"}] ';
            parseJSON(jsonString);
        }
        catch(Exception e ){
            Apexpages.addMessages(e);
        }
    }
    public void parseJSON(String jsonstr){
        if(jsonstr != null){
            modelList = new List<ModelClass>();
            JSONParser parser = JSON.createParser(jsonstr);
            while (parser.nextToken() != null)
            {
                if(parser.getCurrentToken() == JSONToken.START_ARRAY)
                {
                    while (parser.nextToken() !=  JSONToken.END_ARRAY)
                    { 
                         if(parser.getCurrentToken() == JSONToken.START_OBJECT)
                         {
                              ModelClass obj = new ModelClass();  
                              while(parser.nextToken() !=  JSONToken.END_OBJECT)
                              {
                                   if((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&(parser.getText().tolowercase() == 'long_name'))
                                  {
                                         parser.nextToken();
                                       obj.long_name = parser.getText();
                                     
                                  }    
                                   if((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&(parser.getText().tolowercase() == 'short_name'))
                                   {
                                       parser.nextToken();
                                       obj.short_name = parser.getText();
           
                                   }
                                   if(parser.getCurrentToken() == JSONToken.START_ARRAY) 
                                   {
                                       while(parser.nextToken() !=  JSONToken.END_ARRAY)
                                       {
                                            
                                            String Str = parser.getText();
                                            obj.typesList.add(Str);
                                                          
                                       }
                                   }
                                }
                               modelList.add(obj);
                         }  
                    }                                   
                }
             }  
         }
     }
    public class ModelClass{
        public String long_name{get;set;}
        public String short_name{get;set;}
        public List<String> typesList{get;set;}
        public ModelClass(){
            typesList = new List<String>();
        }
    
    }
}