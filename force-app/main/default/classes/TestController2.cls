public with sharing class TestController2{
    public List<String> lstSections { get; set; }

    public TestController2(){
        lstSections = new List<String>();
    }

    public PageReference addSection() {

        lstSections.add('dummy');

        return null;
    }

}