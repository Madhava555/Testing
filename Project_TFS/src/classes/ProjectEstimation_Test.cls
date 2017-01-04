@isTest
public class ProjectEstimation_Test {

    Private Static Void CreateBaseData()
    {
        List<use_case__c> InsertList = new List<Use_case__c>();
    Proposed_Project__c project = new Proposed_Project__c();
    project.name = 'Test Project';
        Project.Architects__c=1;
        Project.No_of_Developers__c =1;
        Project.No_of_QA_Engineers__c=1;
        Project.BSA__c=1;
        Project.Number_of_hours_per_day__c=6;
   		 insert Project;
        
        for(Integer i=0;i<=4;i++)
        {
            use_case__c u = new Use_case__c();
            u.User_Case_Description__c = 'UC'+i;
            u.Dev_Complexity__c = 'Low';
            u.QA_Complexity__c = 'High';
            u.Proposed_Project__c=Project.Id;
            InsertList.add(u);
        }
        Insert InsertList;
    }
    
    static testmethod void  calculateTest()
{
CreateBaseData();
    
    Proposed_Project__c P1= [select id,name,Architects__c,BSA__c,No_of_Developers__c,No_of_QA_Engineers__c,Number_of_hours_per_day__c from Proposed_Project__c where name = 'Test Project'];
    ApexPages.StandardController stdController = new ApexPages.StandardController(P1);
    ProjectEstimation ProjEst = new ProjectEstimation(stdController);
    //ProjectEstimation PE_Controller = Apexpages.StandardController(ProjEst);
    Pagereference pageref = Page.ProjectEstimation;
    Test.setCurrentPage(pageref);
    Test.startTest();
    ProjEst.Calculate();
    ProjEst.SavePlan();
    Test.stopTest();
    
    
}
}