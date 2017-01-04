public class TestPage {
    public list<Proposed_project__C> projlist{get;set;}
    public List<Use_Case__c> usecases{get;set;}
    public TestPage()
    {
       
        projlist = [select id,name,(select id,name,proposed_project__r.id from use_cases__r) from proposed_project__c] ;
        
    }


}