@RestResource(urlMapping='/Case/*')
global class WebServiceforOrgA {
    @HttpPost
    global Static Id createCase(){
        RestRequest req = RestContext.request;
        String requestBody = req.requestBody.toString();
        Map<String, Object> data = (Map<String, Object>)JSON.deserializeUntyped(requestBody);
        Case newCase = new Case();
        for(String field : data.keySet()){
             newCase.put(field, data.get(field));
        }
        try{
            insert newCase;
            return newCase.Id;
        }
        catch(DmlException e){
            System.debug(e.getMessage());
            return null;
    
        }
     }
    @HttpGet
    global Static String testGetMethod(){
        return 'Hello';
    }
}