public class AccountTriggerHandler{
    public static void handleAfterInsert(List<Account> accountList){
        List<PersonDetail__c> pdList = new List<personDetail__c>();
        for(Account acc: accountList){
            PersonDetail__c pd = new PersonDetail__c(
                Name = acc.Name,
                Person_Phone__c = acc.Phone,
                Description__c = acc.Description,
                Person_EmpId__c = acc.Id,
                Parent_Account__c = acc.Id,
                Person_Email__c = acc.Email__c
            );
            pdList.add(pd);
            Database.SaveResult[] insertResults = Database.insert(pdList, false);
            System.debug(insertResults);
        }
        
    }
    public static void createOpportunity(List<Account> accountList){
        
            /*List<Opportunity> opportunityList = new List<Opportunity>();
      
            for(Account acc : accountList){
                Opportunity opp = new Opportunity();
                opp.Name = acc.Name;
                opp.StageName = 'Prospecting';
                opp.CloseDate = system.today();
                opportunityList.add(opp);
            }
        if(Schema.sObjectType.Opportunity.isCreateable()){
            insert opportunityList;
        }            
    
        else {
            System.debug('insufficient access');
        }*/
        
        // Using strip Inaccessible 
        List<Opportunity> opportunityList = new List<Opportunity>();
        for(Account acc : accountList){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate = system.today();
            opportunityList.add(opp);
        }
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
        AccessType.CREATABLE, opportunityList);
            try {
        insert securityDecision.getRecords();
        System.debug('Opportunities successfully inserted.');
        } catch (DmlException e) {
        System.debug('Failed to insert Opportunities: ' + e.getMessage());
        }
        
        // User Mode
        /*List<Opportunity> opportunityList = new List<Opportunity>();
        for(Account acc : accountList){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate = system.today();
            opportunityList.add(opp);
        }
        System.debug('hi');
        Database.insert(opportunityList, AccessLevel.USER_MODE);*/
    }

}