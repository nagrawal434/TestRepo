Public Class documentUpsertDeleteserviceHelper{
    public static string actionOnDocument(String jsonString){
        List<RequestModel> filteredRequestList = new List<RequestModel>();
        List<ContentModel> filteredContentModelList = new List<ContentModel>();
        List<ReturnModel> returnModelList = new List<ReturnModel>();
        Map<Id,Loan__c> loanMap = getLoanMap();
        Integer maxSizeInMb = (25*1000000);
        List<RequestModel> requestList = (List<RequestModel>)System.JSON.deserialize(jsonString, List<RequestModel>.class); 
        for(RequestModel requestModelObj : requestList){
            System.debug('&&&&&&&' +requestModelObj.RecordId);
            System.debug('&&&&&&&' +requestModelObj.isUpsert);
            System.debug('&&&&&&&' +requestModelObj.contents);
            ReturnModel returnModelObj = new ReturnModel();
            
            if(String.isNotBlank(requestModelObj.RecordId)){
                if(!(loanMap.containsKey(requestModelObj.RecordId) && loanMap.get(requestModelObj.RecordId) != null)){
                    returnModelObj.errorText = 'Invalid Id';
                    returnModelObj.errorNo = '10';
                    returnModelList.add(returnModelObj);      
               
               }else{
                    RequestModel validRecord = new RequestModel();
                    if(requestModelObj.contents != null){                        
                        for(ContentModel modelObj : requestModelObj.contents){
                            Attachment attRecord = new Attachment(name= modelObj.Name,body = EncodingUtil.base64Decode(modelObj.Body),contentType = modelObj.ContentType);   
                            attRecord.recalculateFormulas();
                            if(attRecord.bodyLength > maxSizeInMb){
                                returnModelObj.errorText = 'File Size limit is Exceed';
                                returnModelObj.errorNo = '20';
                                returnModelList.add(returnModelObj);           
                            }else{
                                validRecord.contents.add(modelObj);
                            }   
                        }
                    }
                    filteredRequestList.add(validRecord);
                } 
            }
        }   
        system.debug('&&&&&&& Filtered List' +filteredRequestList);         
        return JSON.serialize(returnModelList);  
    }
    public class RequestModel{
        string RecordId;
        string isUpsert;
        List<ContentModel> contents;       
    }
    public class ContentModel{
        string Name;
        string Body;
        string contentType;
    }
    public class ReturnModel{
        string errorText;
        string errorNo;     
    }
    public static Map<Id,Loan__c> getLoanMap(){
        Map<Id,Loan__c> leadMap = new Map<Id,Loan__c>();
        for(Loan__c leadRec : [SELECT id,Zip_Code__c FROM Loan__c]){            
            String leadId = String.valueOf(leadRec.id);
            leadMap.put(leadRec.id,leadRec);
            leadMap.put(leadId.substring(0, 15),leadRec);
        }
        return leadMap;
    }
}