trigger personDetailTrigger on PersonDetail__c (before update) {
    if(Trigger.isUpdate && Trigger.isbefore){
        Person_DetailHandler.handleBeforeUpdate(Trigger.oldMap, Trigger.newMap);
    }
	
}