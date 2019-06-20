public Class LightningPickListController{
    public List<SelectOption> countrieLst {get;set;}
    public String selectedCountry{get;set;}
    public LightningPickListController(){
        countrieLst = new List<SelectOption>();
        countrieLst.add(new SelectOption('','--None--'));
        countrieLst.add(new SelectOption('India','India'));
        countrieLst.add(new SelectOption('China','China'));
        countrieLst.add(new SelectOption('US','US'));
    }
}