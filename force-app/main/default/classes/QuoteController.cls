public class QuoteController{
    
    public Quote quoteRecord;
    public Quote QuoteRe;
    public QuoteController(ApexPages.StandardController stdController){        
        this.quoteRecord = (Quote)stdController.getRecord();
        QuoteRe= [Select id,Looptijd__c,Offerte_URL__c,Collectieve_mantelovereenkomst__c,Toegekend_VoorschotMM__c,(SELECT id,Description,Type_huidig_abonnement__c,Huidige_provider__c,Simkaartnummer__c,Toestel_ID__c,product2.id,Aantal_abonnementen__c,Extra_HW_korting__c,Verkoopprijs_tbv_import__c,X06_nummer__c,Abonnement__c,Einddatum_huidig_contract__c,Klantnummer__c,Modules__c from QuoteLineItems) from Quote Where id=: quoteRecord.id];       
    
    }
    public void InsertUpdateMethod(){
        Insert_Bestelling();
        Insert_Mobile_aansluiting();    
    }
    public void Insert_Bestelling(){
        
        List<Bestellingproduct__c> bestellingProductList= new List<Bestellingproduct__c>();
        List<Bestellingproduct__c> NewbestellingProductList= new List<Bestellingproduct__c>();
         
        if(QuoteRe.QuoteLineItems.size() >0){
            for(QuoteLineItem quoteLineItem: QuoteRe.QuoteLineItems){
                if(quoteLineItem.Toestel_ID__c != null){
                    Bestellingproduct__c bestellingProduct= new Bestellingproduct__c();
                    bestellingProduct.Extra_HW_korting__c= quoteLineItem.Extra_HW_korting__c;
                    bestellingProduct.Hoeveelheid__c= quoteLineItem.Aantal_abonnementen__c;
                    bestellingProduct.Verkoopprijs__c= quoteLineItem.Verkoopprijs_tbv_import__c;
                    bestellingProduct.Product__c=  quoteLineItem.product2.id;
                    bestellingProductList.add(bestellingProduct);   
                }
            }
            if(bestellingProductList.size() >0){
                Bestelling_MM__c bestellingObj= new Bestelling_MM__c();
                bestellingObj.Status__c= 'Lopend';
                bestellingObj.MobileMiles__c= QuoteRe.Toegekend_VoorschotMM__c;
                insert bestellingObj; 
                                 
                for(Bestellingproduct__c  pro: bestellingProductList){
                    Bestellingproduct__c newPro= new Bestellingproduct__c();
                    newPro.Bestelling_MM__c= bestellingObj.id;
                    newPro.Extra_HW_korting__c= pro.Extra_HW_korting__c;
                    newPro.Hoeveelheid__c= pro.Hoeveelheid__c;
                    newPro.Verkoopprijs__c= pro.Verkoopprijs__c;
                    newPro.Product__c=  pro.Product__c;             
                    NewbestellingProductList.add(newPro);          
                }
            }
            if(NewbestellingProductList.size() >0){
                insert NewbestellingProductList;
            }      
        }
    }
    public void Insert_Mobile_aansluiting(){
        System.debug('hey');
        List<Mobile_aansluiting__c> Mobile_aansluitingList=new List<Mobile_aansluiting__c>();
        if(QuoteRe.QuoteLineItems.size() >0){
            for(QuoteLineItem quoteLineItem: QuoteRe.QuoteLineItems){
                Mobile_aansluiting__c Mobile_aansluitingObj= new Mobile_aansluiting__c();
                if(!(quoteLineItem.Huidige_provider__c== 'Mobile Miles (KPN)') && (quoteLineItem.X06_nummer__c.startsWith('06'))){
                    system.debug('wlcmIn');
                    Mobile_aansluitingObj.Contractduur__c = QuoteRe.Looptijd__c;
                    Mobile_aansluitingObj.Gerelateerde_offerte__c= QuoteRe.Offerte_URL__c;
                    Mobile_aansluitingObj.Collectieve_mantelovereenkomst__c= QuoteRe.Collectieve_mantelovereenkomst__c ;
                    Mobile_aansluitingObj.name= quoteLineItem.X06_nummer__c;
                    Mobile_aansluitingObj.Abonnement__c= quoteLineItem.Abonnement__c; 
                    Mobile_aansluitingObj.Einddatum__c= quoteLineItem.Einddatum_huidig_contract__c;
                    Mobile_aansluitingObj.Klantnummer__c= quoteLineItem.Klantnummer__c;
                    Mobile_aansluitingObj.Modules__c= quoteLineItem.Modules__c; 
                    Mobile_aansluitingObj.Opmerkingen__c= quoteLineItem.Description;     
                    Mobile_aansluitingObj.Provider__c= quoteLineItem.Huidige_provider__c ;
                    Mobile_aansluitingObj.Simkaartnummer__c= quoteLineItem.Simkaartnummer__c ;
                    Mobile_aansluitingObj.Type__c=quoteLineItem.Type_huidig_abonnement__c;
                    Mobile_aansluitingList.add(Mobile_aansluitingObj);               
                }        
            }
            if(Mobile_aansluitingList.size() >0){
                insert  Mobile_aansluitingList;
            }
        }              
    }
     public void UpdateMobiele_aansluiting_Record(){
        Set<String> nameSet = new Set<String>();
        if(QuoteRe.QuoteLineItems.size()>0){
            for(QuoteLineItem obj : QuoteRe.QuoteLineItems){
                if(obj.Huidige_provider__c=='Mobile Miles (KPN)' && obj.X06_nummer__c.startsWith('06')){
                    nameSet.add(obj.X06_nummer__c);
                }
            } 
            
            List<Mobile_aansluiting__c> mobileList = [select id,Fase__c,Contractduur__c,Gerelateerde_offerte__c,
                                                        Collectieve_mantelovereenkomst__c,Abonnement__c,
                                                        Einddatum__c,Klantnummer__c,Modules__c,Opmerkingen__c,
                                                        Provider__c,Simkaartnummer__c,Type__c,
                                                        Verlengen_zodra_mogelijk__c from Mobile_aansluiting__c 
                                                        where name IN: nameSet];
            system.debug('@@@1' + mobileList);                                                            
            
            if(mobileList.size() > 0){
                for(QuoteLineItem objL : QuoteRe.QuoteLineItems){
                    for(Mobile_aansluiting__c objM : mobileList){
                        objM.Verlengen_zodra_mogelijk__c = 'True';
                        objM.Contractduur__c = QuoteRe.Looptijd__c ;
                        objM.Gerelateerde_offerte__c = QuoteRe.Offerte_URL__c ;
                        objM.Collectieve_mantelovereenkomst__c = QuoteRe.Collectieve_mantelovereenkomst__c ;
                        objM.name = objL.X06_nummer__c;
                        objM.Abonnement__c = objL.Abonnement__c ;
                        objM.Einddatum__c = objL.Einddatum_huidig_contract__c;
                        objM.Klantnummer__c = objL.Klantnummer__c ;
                        objM.Modules__c = objL.Modules__c ;
                        objM.Opmerkingen__c = objL.Description ;
                    }                        
                }
            }
            if(mobileList.size()>0)
                update mobileList;
        }
    }
}