public class DMLoperations {
    public static void insertAccount1(List<String> name, List<String> industry, List<Double> revenue){
        List<Account> accountList = new List<Account>();
        for(Integer i=0; i<name.size();i++){
            Account newAccount = new Account(
                Name = name[i],
                Industry = industry[i],
                AnnualRevenue = revenue[i] 
            );
            accountList.add(newAccount);
        }
        insert accountList;
    }
    public static void insertContact(){
        List <Account> accList = [SELECT Id FROM Account WHERE Name = 'New Tech Inc'];
        List<Contact> contactList = new List<Contact>{
            new Contact(
                FirstName = 'Emily',
                LastName = 'Johnson',
                Email = 'emily.johnson@example.com',
                AccountId = accList[0].Id
            )
        };
        Database.SaveResult[] insertResults = Database.insert(contactList, false);
    }
    public static void updateRecords(){
        List<Account> accToUpdate = [SELECT Id,AnnualRevenue FROM Account WHERE Name = 'New Tech Inc'];
        acctoUpdate[0].AnnualRevenue = 1000;
        update acctoUpdate;
        /*
        List<Contact> contoUpdate = [SELECT Email FROM Contact WHERE FirstName = 'Emily' AND LastName = 'Johnson'];
        contoUpdate[0].Email = 'emily.johnson.updated@example.com';
        Database.SaveResult[] updateResults = Database.update(contoUpdate, false);
*/
    }
    public static void upsertRecords(){
        List<Account> existingAcc = [SELECT Id, BillingCountry FROM Account];
        for(Account acc: existingAcc){
            acc.BillingCountry = 'India';
        }
        existingAcc.add(new Account(
            Name = 'Shivi',
            Industry = 'Salesforce'
        ));
        upsert existingAcc;
    }
    public static void deleteRecords(){
        List<Contact> recordstoDelete = [SELECT Id FROM Contact WHERE FirstName = 'Emily' AND LastName = 'Johnson'];
        Database.DeleteResult[] deleteResults = Database.delete(recordstoDelete, False);
    }
    public static void undeleteRecords(){
        List<Contact> recordstoRestore = [SELECT Name FROM Contact WHERE FirstName = 'Emily' AND LastName = 'Johnson' ALL ROWS];
        //System.debug(recordstoRestore);
        Database.UndeleteResult[] undeleteResults = Database.undelete(recordstoRestore, False);
    }
}