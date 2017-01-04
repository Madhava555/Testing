public class ProjectEstimation {
  
    public integer hoursperweek;
    //Public integer numofWeeks{get;set;}
    public Integer	Project_Manager{Get;Set;}
    public Decimal PM_Allocation{get;set;}
    public integer PM_Billing{get;set;}
    public Proposed_Project__c project{get;set;}
    public Decimal Architect_Allocation{get;set;}
    public integer Architect_Billing{get;set;}
    public Decimal BSA_Allocation{get;set;}
    public integer BSA_Billing{get;set;}
    public Decimal Dev_Allocation{get;set;}
    public integer Dev_Billing{get;set;}
    public Decimal QA_Allocation{get;set;}
    public integer QA_Billing{get;set;}
    public Decimal Weeks_per_Sprint{get;set;}
    public Decimal No_Of_Sprints{get;set;}
	
    
    
//public boolean Test{get;set;}

        
    
      public ProjectEstimation(ApexPages.StandardController controller) {
          
          project = (Proposed_Project__c)controller.getRecord();
          system.debug('****Project'+Project);
          Project.Architects__c=1;
          Project.BSA__c=1;
          Project.No_of_Developers__c=1;
          Project.No_of_QA_Engineers__c=1;
          Project.Number_of_hours_per_day__c =8;
          this.Project_Manager = 1;
          This.PM_Allocation = 100;
          this.PM_Billing=100;
          this.Architect_Allocation=100;
          this.Architect_Billing=100;
          this.BSA_Allocation=100;
          this.BSA_Billing=100;
          this.Dev_Allocation=100;
          this.Dev_Billing=100;
          this.QA_Allocation=100;
          this.QA_Billing=100;
          this.Weeks_per_Sprint=2;              
         
        
          
  }
    Public Pagereference Calculate()
    {
        proposed_project__c projfromDB = [select id,total_effort__c,Project_Description__c,No_of_QA_Engineers__c,Number_of_hours_per_day__c from proposed_project__c where id=:Project.Id ]  ; 
        
        hoursperweek=Integer.valueOf(project.Number_of_hours_per_day__c*5);
        system.debug('hoursperweek'+hoursperweek);
        Integer totalnumofppl = Integer.valueOf(project.No_of_Developers__c) + Integer.valueOf(project.No_of_QA_Engineers__c);
        system.debug('totalnumofppl'+totalnumofppl);
        decimal a= hoursperweek*totalnumofppl;
        system.debug('a'+a);
        project.Number_of_weeks__c=math.Ceil(projfromDB.Total_Effort__c/a);
        system.debug('NumberOfWeeks'+project.Number_of_weeks__c);
        
        System.debug('Allocation****'+PM_Allocation+';'+Architect_Allocation+';'+BSA_Allocation+';'+Dev_Allocation+';'+QA_Allocation);
        
        decimal PM_Alloc_weeks = (PM_Allocation/100)*project.Number_of_weeks__c;
        decimal Arc_Alloc_weeks = (Architect_Allocation/100)*project.Number_of_weeks__c;
        Decimal BSA_Alloc_Weeks = (BSA_Allocation/100)*project.Number_of_weeks__c;
        Decimal Dev_Alloc_Weeks = (Dev_Allocation/100)*project.Number_of_weeks__c;
        Decimal QA_Alloc_Weeks = (QA_Allocation/100)*project.Number_of_weeks__c;
        
        System.debug('Alloc_Weeks****'+PM_Alloc_Weeks+';'+Arc_Alloc_weeks+';'+BSA_Alloc_weeks+';'+Dev_Alloc_weeks+';'+QA_Alloc_weeks);
        
        Decimal PM_Hours = math.ceil(PM_Alloc_weeks*40);
        Decimal Arc_Hours = math.ceil(Arc_Alloc_weeks*40);
        Decimal BSA_Hours = math.ceil(BSA_Alloc_weeks*40);
        Decimal Dev_Hours = math.ceil(Dev_alloc_weeks*40);
        Decimal QA_Hours = math.ceil(QA_Alloc_weeks*40);
        
        System.debug('Hours****'+PM_Hours+';'+Arc_Hours+';'+BSA_Hours+';'+Dev_Hours+';'+QA_Hours);
        
        Project.Total_Cost__c = (Project_Manager*PM_Hours*PM_Billing)+(Project.Architects__c*Arc_Hours*Architect_Billing)+(Project.BSA__c*BSA_Hours*BSA_Billing)+( project.No_of_Developers__c*Dev_Hours*Dev_Billing)+(Project.No_of_QA_Engineers__c*QA_Hours*QA_Billing);
        System.debug('Billing****'+PM_Billing+';'+Architect_Billing+';'+BSA_Billing+';'+Dev_Billing+';'+QA_Billing);
        No_Of_Sprints = math.ceil(Project.Number_of_weeks__c/Weeks_per_Sprint);
        
      
 //Test=True;
      return null;
      //
    }
        Public Pagereference SavePlan()
        {
         	//List<Project_Plan__c> pp = new List<Project_Plan__c>();
            Project_plan__c pp = new Project_Plan__C();
            
            system.debug('Arc******'+Project.Architects__c);
            system.debug('Weeks****'+Project.Number_of_weeks__c);
            pp.Architects__c = Project.Architects__c;
            pp.BSA__c = Project.BSA__c;
            pp.Number_of_Dev_Resources__c = project.No_of_Developers__c;
            pp.Number_of_QA_Resources__c = Project.No_of_QA_Engineers__c;
            pp.Number_of_Weeks__c = Project.Number_of_weeks__c;
            system.debug('projectidsave'+Project.Id);
            system.debug('ppid'+pp.Proposed_Project__r.id);
            pp.Proposed_Project__c = Project.Id;
            pp.Project_Manager__c = Project_Manager;
            Insert pp;
            return Null;
        }
}