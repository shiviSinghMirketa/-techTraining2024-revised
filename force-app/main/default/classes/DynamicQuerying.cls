public class DynamicQuerying {
    public static void queryRecords(String objectName, List<QuerryWrapper> conditions){
        
        List<SObject> retrievedRecords = new List<SObject>();
        String query = 'SELECT Id FROM ' + objectName + ' WHERE ';
        Map<String, Object> bindVariables = new Map<String, Object>();
        for(Integer i = 0; i < conditions.size(); i++){
            bindVariables.put('value' + i, conditions[i].conditionValue);
            query += conditions[i].fieldName + ' ' + '= ' + ':value' + i;
            if(i != conditions.size()-1) query += ' AND ';
        }
        retrievedRecords = Database.queryWithBinds(query, bindVariables, AccessLevel.USER_MODE);
        System.debug(retrievedRecords);
        System.debug('Dynamic SOQL Query: ' + query);
        

    }
}