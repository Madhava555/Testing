public class RequestformExtn {

    public Environment_Request_Form__c requestform {get;set;}
    public Environment_Request_Form__c env{get;set;}
    
    public boolean CancelClick {get;set;}
    public boolean SaveClick {get;set;}
    
    
    public RequestformExtn(ApexPages.StandardController controller) {
        requestform = (Environment_Request_Form__c)controller.getRecord();
        requestform.Requester_Name__c = UserInfo.getUserId() ;
        requestform.Request_Status__c = 'New';
        if(env!=null){
            setupEnv();
        }
        
  }
  
  
  
  private void setupEnv()
   {
       if (null!=requestform.Environment_name_lookup__c&&requestform.Request_Type__c == 'Environment Extension')
       {
           env=[select id, Project_Name__c,Project_Owner__c,CP_FR__c,Reason_For_Extension__c,End_Date__c,
               Planned_Go_Live__c,Project_Description__c,Extension_Till__c,Environment_name_lookup__r.Sandbox_Owner__c,Environment_name_lookup__r.Sandbox_Type__c,
               Environment_name_lookup__r.Instance_Name__c,Environment_name_lookup__r.Next_Refresh_Date__c,Environment_name_lookup__r.Version__c from Environment_Request_Form__c
               where Environment_name_lookup__c= :requestform.Environment_name_lookup__c LIMIT 1];
       }
   }

   public PageReference MyMethod()
   {
      setupEnv();
      return null;
   }
   
   public PageReference EvnDetail()
   {
      setupEnv();
      return null;
   }
   
   
   
   
   public PageReference DoSave() {
   
        
        SaveClick= true;
        if(env!=null){
            update env;
        }
        insert requestform;
        PageReference pageref= new ApexPages.PageReference('/apex/EnvironmentRequestForm');
        pageref.setRedirect(true);
        SaveClick= false;
        
        return pageref;
        
       
  }
    public PageReference DoCancel() {
    
        CancelClick= true;
        PageReference pageref= new ApexPages.PageReference('/apex/EnvironmentRequestForm');
        pageref.setRedirect(true);
        CancelClick= false;
        return pageref;
        
        
       


  }
  
  
}