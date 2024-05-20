public class Person_DetailHandler {
    public static void handleBeforeUpdate(Map<Id,personDetail__c> oldMap, Map<Id,personDetail__c> newMap){
        
        for(Id key : newMap.keySet()){
            if(oldMap.get(key).Person_Phone__c != newMap.get(key).Person_Phone__c){
                newMap.get(key).Description__c = 'Phone no. is updated to '+  newMap.get(key).Person_Phone__c + 'from ' + oldMap.get(key).Person_Phone__c;
            }
            else if(oldMap.get(key).Person_Email__c != newMap.get(key).Person_Email__c){
                newMap.get(key).Description__c = 'Email is updated to ' + newMap.get(key).Person_Email__c + 'from ' + oldMap.get(key).Person_Email__c;
            }
        }
    }
}