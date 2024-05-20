trigger SubsribeToLead on New_Lead__e (after insert) {
    // subscribe 
    List<New_Lead__e> newEvents = Trigger.new;
    System.debug(Trigger.new);
    List<Account> accList = new List<Account> ();
    for(Integer i=0;i<newEvents.size();i++){
        Account newAcc = new Account(
            Name = newEvents[i].Name__c
        );
        accList.add(newAcc);
    }
    insert accList;
}