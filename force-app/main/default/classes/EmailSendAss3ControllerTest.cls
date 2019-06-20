@isTest
public class EmailSendAss3ControllerTest{

   @isTest
   static void SendMailTest(){
       EmailSendAss3Controller obj= new EmailSendAss3Controller();
       
       EmailSendAss3Controller.ModelContactClass omod= new EmailSendAss3Controller.ModelContactClass();
       obj.getemailTemplateList();
       EmailTemplate e = new EmailTemplate (developerName = 'test', TemplateType= 'Text', Name = 'test',folderID= UserInfo.getUserId()); 
       insert e;
       obj.emailIdList= e.id;
       obj.sendTemplate();
   }
}