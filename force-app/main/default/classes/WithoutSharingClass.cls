public without sharing class WithoutSharingClass {
    
    @AuraEnabled
    public static Integer countAccounts() {
        //CRUD, FLS and Sharing rules are not enforced
        return [Select Id, Name, Rating from Account].size();
    }
    
    @AuraEnabled
    //Query
    public static void performDML() {
        //CRUD, FLS and Sharing rules are not enforced 
        List<Contact> conList = new List<Contact>();
        List<Account> acc = [Select Name,Id from Account WHERE Name = 'University of Arizona' LIMIT 1];
        for (Account a: acc) {
            Contact con = new Contact();
            con.LastName = a.Name;
            conList.add(con);
        }
        insert conList;
    }
    
    public static void performDML(List<Account> acc) {
        List<Contact> conList = new List<Contact>();
        for (Account a: acc) {
            Contact con = new Contact();
            con.LastName = a.Name;
            conList.add(con);
        }
        insert conList;
    }
    
    @AuraEnabled
    //query
    public static void performDMLWithSharing() {
        //CRUD, FLS and Sharing rules are not enforced 
           //List<Contact> conList = new List<Contact>();
           List<Account> acc = [Select Name,Id from Account WHERE Name = 'View' LIMIT 1];
        //    for (Account a: acc) {
        //        Contact con = new Contact();
        //        con.LastName = a.Name;
        //        conList.add(con);
        //    }
        //    insert conList;
        //CRUD, FLS are not enforced. Sharing rules are enforced
        WithSharingClass.performDML(acc);
    }
    
    @AuraEnabled
    public static void performDMLInheritedSharing() {
        //CRUD, FLS and Sharing rules are not enforced 
        InheritedSharing.performDML();
    }
    
    @AuraEnabled
    public static String CRUD() {
        //Adding checks for CRUD
        if (Schema.SObjectType.Account.isAccessible()) {
            return 'Access Denied';
        } else {
            return 'Access Provided';
        }
    }
    
    @AuraEnabled
    public static String FLS() {
        //Adding Checks for FLS
        if (Schema.SObjectType.Account.fields.Name.isAccessible()) {
            return 'Access Denied';
        } else {
            return 'Access Provided';
        }
    }
    
    @AuraEnabled
    public static void stripInaccessibleSOQL() {
        //CRUD, FLS is enforced
        //Sharing rules are not enforced
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
                                         AccessType.READABLE, [Select id from Account]);
        System.debug(securityDecision.getRecords());
    }
    
    @AuraEnabled
    public static void stripInaccessibleDML() {
        //CRUD, FLS is enforced
        //Sharing rules are not enforced
        List<Account> newAccounts = new List<Account>();
        Account a = new Account(Name='Acme Corporation');
        Account b = new Account(Name='Blaze Comics', Rating='Warm');
        newAccounts.add(a);
        newAccounts.add(b);
        
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
            AccessType.CREATABLE, newAccounts);
        
        // No exceptions are thrown and no rating is set
        insert securityDecision.getRecords();
        
        System.debug(securityDecision.getRemovedFields().get('Account')); // Prints "Rating"
        System.debug(securityDecision.getModifiedIndexes()); // Prints "1"
    }
    
    @AuraEnabled
    public static void securityEnforcedSOQL() {
         //CRUD, FLS is enforced
         //Sharing rules are not enforced
         System.debug([Select Id, Name, Rating from Account WITH SECURITY_ENFORCED].size());
    }
    
    @AuraEnabled
    public static void withSecuirtyEnforcedAndWhereClause() {
         //CRUD, FLS is enforced
         //Sharing rules are not enforced
         System.debug([Select Id, Name from Account where Rating = 'Warm' WITH SECURITY_ENFORCED].size());
    }
    
    @AuraEnabled
    public static void withUserModeAndWhereClause() {
         //CRUD, FLS and Sharing Rule is enforced
         System.debug([Select Id, Name from Account where Rating = 'Warm' WITH USER_MODE].size());
    }
    
    @AuraEnabled
    public static void performDMLWithUserMode() {
         Account a = [Select Id from Account where Name = 'System Admin Created' LIMIT 1];
         //CRUD, FLS and Sharing Rule is enforced
         update as user a;
    }
}