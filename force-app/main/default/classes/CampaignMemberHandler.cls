public class CampaignMemberHandler{
    public CampaignMemberHandler(){
    
    }
    public void onAfterInsert(List<CampaignMember> newCampaignMemberList){
        onInsertupdateApplicationRecords(newCampaignMemberList);            
    }
    public void onDeleteCampaignMember(List<CampaignMember> toBeDeletedCampaignMemberList){
        onDeleteUpdateApplicationRecord(toBeDeletedCampaignMemberList);   
    }
    private void onInsertupdateApplicationRecords(List<CampaignMember> newCampaignMemberList){
        Set<String> applicationIds = new Set<String>();
        List<CampaignMember> allCampaignMemberList = new List<CampaignMember>();
        Map<String,Set<String>> campaignMemberMap = new Map<String,Set<String>>();
        List<Member_Aplication__c> memberAplicationList = new List<Member_Aplication__c>();
        Map<String,Campaign> campaignDateMap = new Map<String,Campaign>();
        List<Campaign> campaignList = new List<Campaign>();
        Set<String> campaignIds = new Set<String>();  
        for(CampaignMember member : newCampaignMemberList){
            System.debug('*****member.campaign.type' +member.campaign.type);
            System.debug('*****member.Member_Aplication__c' +member.Member_Aplication__c);
            if(member.Member_Aplication__c != null)
                applicationIds.add(member.Member_Aplication__c);
                campaignIds.add(member.CampaignId);                       
        }
        System.debug('*****applicationIds' +applicationIds);
        allCampaignMemberList  = [Select id,Member_Aplication__c,CampaignId,Campaign.Type,status,Campaign.startDate from CampaignMember 
                                  where Member_Aplication__c IN :applicationIds AND Campaign.Type = 'Mentor Orientation'];        
        
        if(campaignIds.size() > 0){
            campaignList = [SELECT Id,StartDate,type from Campaign where id IN :campaignIds];
        }
        if(campaignList.size() > 0 && campaignList != null){
           for(Campaign campaignRecord : campaignList){
                if(campaignRecord.startDate != null)
                    campaignDateMap.put(campaignRecord.id,campaignRecord);
            }         
        } 
        System.debug('*****allCampaignMemberList' +allCampaignMemberList);
        if(allCampaignMemberList.size() > 0 && allCampaignMemberList != null){
            for(CampaignMember campaignMemberObj : allCampaignMemberList){
                Set<String> memberStatusSet = new Set<String>(); 
                if(!campaignMemberMap.ContainsKey(campaignMemberObj.Member_Aplication__c)){
                    memberStatusSet = new Set<String>();    
                }
                memberStatusSet.add(campaignMemberObj.status);
                campaignMemberMap.put(campaignMemberObj.Member_Aplication__c,memberStatusSet);               
            }
        }
        for(CampaignMember member : newCampaignMemberList){
            System.debug('*****member' +member);
            if(campaignDateMap.get(member.CampaignId) != null && campaignDateMap.get(member.CampaignId).Type == 'Mentor Orientation'){
                Member_Aplication__c memberAppRecord = new Member_Aplication__c(); 
                if(campaignMemberMap.containsKey(member.Member_Aplication__c) && campaignMemberMap.get(member.Member_Aplication__c) != null){
                    System.debug('*****campaignMemberMap' +campaignMemberMap);
                    System.debug('*****member.status' +member.status);
                    if(member.status == 'Attended'){
                        memberAppRecord.id =  member.Member_Aplication__c;
                        if(campaignDateMap.get(member.campaignId) != null)
                            memberAppRecord.Completed_Training_Date__c = campaignDateMap.get(member.CampaignId).StartDate;
                        memberAppRecord.Scheduled_Training_Date__c = null;
                        memberAplicationList.add(memberAppRecord);
                        System.debug('*****memberAppRecord' +memberAppRecord);        
                    }else if(member.status == 'Scheduled'){
                        set<String> statusSet = campaignMemberMap.get(member.Member_Aplication__c);
                        if(!(statusSet.contains('Attended'))){
                            memberAppRecord.id =  member.Member_Aplication__c;
                            System.debug('*****memberAppRecord' +member.Campaign.startDate);
                            if(campaignDateMap.get(member.campaignId) != null)
                                memberAppRecord.Scheduled_Training_Date__c  = campaignDateMap.get(member.CampaignId).StartDate;
                            memberAppRecord.Completed_Training_Date__c= null;                       
                            memberAplicationList.add(memberAppRecord);
                            System.debug('*****memberAppRecord' +memberAppRecord);  
                        }        
                    }else if(member.Status == 'Did Not Attend - Need to Reschedule' || member.Status == 'Canceled - Need to Reschedule'){
                        set<String> statusSet = campaignMemberMap.get(member.Member_Aplication__c);
                        if(!(statusSet.contains('Attended') || statusSet.contains('Scheduled'))){
                            memberAppRecord.id =  member.Member_Aplication__c;
                            memberAppRecord.Scheduled_Training_Date__c  = null;
                            memberAppRecord.Completed_Training_Date__c= null;                       
                            memberAplicationList.add(memberAppRecord);
                            System.debug('*****memberAppRecord' +memberAppRecord);  
                        }        
                    }    
                }
            }              
        } 
        System.debug('*****memberAplicationList' +memberAplicationList);
        if(memberAplicationList.size() > 0 && memberAplicationList != null){
            update memberAplicationList;
        }  
    }
    private void onDeleteUpdateApplicationRecord(List<CampaignMember> toBeDeletedCampaignMemberList){
       /* Set<String> aplicationIds = Set<String>();
        List<CampaignMember> allCampaignMemberList = new List<CampaignMember>(); 
        for(CampaignMember memberRecord : toBeDeletedCampaignMemberList){
            if(memberRecord.Member_Aplication__c != null){
                aplicationIds.add(memberRecord);            
            }
        }     
        if(aplicationIds.size() >0 && aplicationIds != null){
            allCampaignMemberList = [Select id,Member_Aplication__c,CampaignId,Campaign.Type,status,Campaign.startDate from CampaignMember 
                              where Member_Aplication__c IN :applicationIds AND Campaign.Type = 'Mentor Orientation'];                              
        }
        if(allCampaignMemberList.size() > 0 && allCampaignMemberList != null){
            for(CampaignMember campaignMemberObj : allCampaignMemberList){
                Set<String> memberStatusSet = new Set<String>(); 
                if(!campaignMemberMap.ContainsKey(campaignMemberObj.Member_Aplication__c)){
                    memberStatusSet = new Set<String>();    
                }
                memberStatusSet.add(campaignMemberObj.status);
                campaignMemberMap.put(campaignMemberObj.Member_Aplication__c,memberStatusSet);               
            }
        }
        if(campaignIds.size() > 0){
        campaignList = [SELECT Id,StartDate,type from Campaign where id IN :campaignIds];
        }
        if(campaignList.size() > 0 && campaignList != null){
           for(Campaign campaignRecord : campaignList){
                if(campaignRecord.startDate != null)
                    campaignDateMap.put(campaignRecord.id,campaignRecord);
            }         
        }            
        for(CampaignMember member : newCampaignMemberList){
                                        
        } */
    } 
}