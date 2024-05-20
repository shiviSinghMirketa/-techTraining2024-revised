public inherited sharing class InheritedSharing {
	public static void performDML() {
        List<Account> a = [Select Id from Account where Name = 'Account Tech Inc' LIMIT 1];
        List<Contact> contactList = new List<Contact>();
        for(Account acc : a){
            Contact c = new Contact(AccountId = acc.Id, LastName = acc.Name);
            contactList.add(c);
        }
        insert contactList;
    }
}