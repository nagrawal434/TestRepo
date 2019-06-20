@isTest
public class TestHelperCloneOpportunityProducts{
   @isTest
   public static void testopp(){
       Id pricebookId = Test.getStandardPricebookId();
       Pricebook2 pb = new Pricebook2(Name = 'Standard Price Book 2009', Description = 'Price Book 2009 Products', IsActive = true);
       insert pb;
       system.debug('##'+pb.id);
       Product2 product = new Product2();
       product.Name='Test Product';
       product.IsActive=true;
       insert product ;
       
       PricebookEntry pbe = new PricebookEntry();
       pbe.Pricebook2Id=pricebookId;
       pbe.Product2Id=product.id;
       pbe.IsActive=true;
       pbe.UnitPrice=0;
       insert pbe;
       system.debug('##'+pbe.UnitPrice);
       Opportunity objOpp1= new Opportunity();
       objOpp1.Name = 'Testing12';
       objOpp1.StageName = 'Upside';
       objOpp1.CloseDate = System.Today();
       insert objOpp1;
       Opportunity objOpp2= new Opportunity();
       objOpp2.Name = 'TestingSecond';
       objOpp2.StageName = 'Upside';
       objOpp2.CloseDate = System.Today();
       insert objOpp2;
       system.debug('%%%%%'+objOpp2);
       OpportunityLineItem NewRec = new OpportunityLineItem();
       NewRec.TotalPrice=12;
       NewRec.Quantity=1;
       NewRec.OpportunityId=objOpp1.Id;
       NewRec.PricebookEntryId=pbe.id;
       insert NewRec;
       
       
       System.assertEquals(1,[select id from OpportunityLineItem where OpportunityId=:objOpp1.id].size());
   }
}