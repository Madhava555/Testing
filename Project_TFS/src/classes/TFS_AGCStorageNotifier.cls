public class TFS_AGCStorageNotifier{

    public List<agf__ADM_Work__c> WorkList{get;set;}
    public List<AggregateResult> attachmentlist;


    public TFS_AGCStorageNotifier(){
        WorkList =[Select Id,agf__Type__c,agf__Subject__c,agf__Scrum_Team__r.Name,agf__Scrum_Team__r.agf__Total_Members__c,
                    agf__Product_Tag__r.Name from agf__ADM_Work__c];
        attachmentlist=[SELECT count(ID),bodylength,Parent.name FROM Attachment where ParentID IN: WorkList GROUP BY bodylength,Parent.name];
    }
    
    
    
}