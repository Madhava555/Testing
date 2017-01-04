Public Class TFSC_DataMasking{

Public Void dataMasking(){
       
       /* Person Account */    
       List<Account> personAccounts = [Select Id,FirstName,LastName,Person_Employer_Name__pc,Social_Security_Number__pc from Account where IsPersonAccount = true];
       /* Business Account */
       List<Account> businessAccounts = [Select Id,RecordTypeId,Tax_Identification_Number__c from Account where IsPersonAccount = false];
       List<Account> personBusinessAccountMasked = new List<Account>();
       /* Collateral */
       Integer i = 100000;
       
       List<Collateral__c> collateralLst = [select Id,Name,Vehicle_Identification_Number__c from Collateral__c];
       List<Collateral__c> collateralLstMasked = new List<Collateral__c>();
       /* Financial Account */
       List<Financial_Account__c> financialAccounts = [select Id,ACH_Account_Number__c,ACH_Routing_Number__c,Communication_Comments__c from Financial_Account__c];
       List<Financial_Account__c> financialAcctsMasked = new List<Financial_Account__c>();
       /* Financial Account Customer */
       List<Financial_Account_Customer__c> financialAcctsCustomer = [select Id,Name,HomePhone_BillTo__c,Home_Phone_Garage__c,Mailing_BillTo_Name__c,Mailing_City_BillTo__c,Mailing_City_Garage__c,
                                Mailing_Postal_Code_Garage__c,Mailing_Street_Garage__c,Mobile_Phone__c,Servicing_Email__c,Work_Phone_Bill_To__c,Work_Phone_Garage__c from Financial_Account_Customer__c];
       List<Financial_Account_Customer__c> financialAcctsCustomerMasked = new List<Financial_Account_Customer__c>();
       
       
         /*Person Account Data Masking */
         if(personAccounts.size()>0){
             for(Account personAccount:personAccounts){
                     personAccount.FirstName = 'Masked';
                     personAccount.LastName = 'Person Account';
                     personAccount.Person_Employer_Name__pc = 'employed';
                     personAccount.Social_Security_Number__pc = '111111111';   
                             
                     //system.debug('++++++personAccount.Social_Security_Number__pc++++++'+personAccount.Social_Security_Number__pc);
                     personBusinessAccountMasked.add(personAccount);
               }
          } 
           /* Business Account Data Masking */
         if(businessAccounts.size()>0){  
             for(Account businessAccount:businessAccounts){      
                     businessAccount.RecordTypeId = '012700000001fLuAAI';
                     businessAccount.Tax_Identification_Number__c = '222222222';
                     
                     personBusinessAccountMasked.add(businessAccount);
              }  
          }
          /* Collateral Data Masking */
          if(collateralLst.size()>0){
              for(Collateral__c collateral:collateralLst){
                    collateral.Name = '1ZZZZ11ZZZZ'+i; 
                    collateral.Vehicle_Identification_Number__c = '1ZZZZ11ZZZZ'+i;
                    i++;
                    collateralLstMasked.add(collateral);
             } 
     
         } 
          /* Financial Account Data Masking */
         if(financialAccounts.size()>0){ 
             for(Financial_Account__c financialAccount:financialAccounts ){
                    financialAccount.ACH_Account_Number__c = '1111111111';
                    financialAccount.ACH_Routing_Number__c = '111111111';
                    financialAccount.Communication_Comments__c = 'General Comments';
                   
                   financialAcctsMasked.add(financialAccount);
             } 
         }
          /* Financial Account Customer Data Masking */
         if(financialAcctsCustomer.size()>0){
         for(Financial_Account_Customer__c financialAcctCustomer:financialAcctsCustomer){
               financialAcctCustomer.Name = 'Masked FAC'; 
               financialAcctCustomer.HomePhone_BillTo__c = '2137441212';
               financialAcctCustomer.Home_Phone_Garage__c = '2137441212'; 
               financialAcctCustomer.Mailing_BillTo_Name__c = '';
               financialAcctCustomer.Mailing_City_BillTo__c = '';
               financialAcctCustomer.Mailing_City_Garage__c = 'Torrance Town';
               financialAcctCustomer.Mailing_Postal_Code_Garage__c = '11111';
               financialAcctCustomer.Mailing_Street_Garage__c = '123 any street';
               financialAcctCustomer.Mobile_Phone__c = '2137441212'; 
               financialAcctCustomer.Servicing_Email__c =  'XYZ123@yahoo.com';
               financialAcctCustomer.Work_Phone_Bill_To__c = '2137441212';
               financialAcctCustomer.Work_Phone_Garage__c = '2137441212';

               financialAcctsCustomerMasked.add(financialAcctCustomer);
               }
         }
         system.debug('++++++list size+++++++'+personBusinessAccountMasked.size());
            if(personBusinessAccountMasked.size()>0)
                update personBusinessAccountMasked;
            
            if(collateralLstMasked.size()>0){
                update collateralLstMasked;
            }
            if(financialAcctsMasked.size()>0){
                update financialAcctsMasked;
            }
            if(financialAcctsCustomerMasked.size()>0){
                update financialAcctsCustomerMasked;
            }
 
   }

  
}