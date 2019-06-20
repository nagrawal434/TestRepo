public class Multi_Lookup_Controller{
    @AuraEnabled
    public static List<RecordWrraper> getsObjectRecord(String sObjectName,String LikeStr, String sortDesciption){
          LikeStr = LikeStr + '%';
          List<RecordWrraper> listTorReturn = new List<RecordWrraper>();
          for(Sobject sObjectRecord : Database.query('Select Id,Name,'+sortDesciption+' From '+sObjectName+' Where Name Like : LikeStr Limit 5')){
              RecordWrraper RecordWrraperObj = new RecordWrraper();
              RecordWrraperObj.name = (String) sObjectRecord.get('Name');
              RecordWrraperObj.sortDesciption = (String) sObjectRecord.get(sortDesciption);
              RecordWrraperObj.id= (String) sObjectRecord.get('id');
              listTorReturn.add(RecordWrraperObj);
          }    
          System.debug('listTorReturn '+listTorReturn);
          return listTorReturn;
    }
    public class RecordWrraper{
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public String sortDesciption{get;set;}
        @AuraEnabled
        public String id{get;set;}
        public RecordWrraper(){
            name = '';
            sortDesciption = '';
        }
    }
}