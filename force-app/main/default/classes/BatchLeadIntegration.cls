public with sharing class BatchLeadIntegration {
    
    private static String getEndpoint(String apiName) {
        API_Configuration__mdt config = [SELECT Endpoint_URL__c FROM API_Configuration__mdt WHERE Label = :apiName LIMIT 1];
        return config.Endpoint_URL__c;
    }
    
    @AuraEnabled(cacheable=false)
    public static String addressVerificationAPI(String reqBody) {
        String endpoint = getEndpoint('AddressVerificationAPI');
        String requestBody = reqBody;
        HttpResponse res = BatchLeadsCalloutAPI.calloutAPI(endpoint, requestBody);
        handleResponse(res);
        String responseBody = res.getBody();
        return responseBody;
    }
    
    @AuraEnabled(cacheable=false)
    public static String addressAutocompleteAPI(String reqBody){
        String endpoint = getEndpoint('addressAutocompleteAPI');
        String requestBody = reqBody;
        HttpResponse res = BatchLeadsCalloutAPI.calloutAPI(endpoint, requestBody);
        handleResponse(res);
        String responseBody = res.getBody();
        return responseBody;
    }
    
    @AuraEnabled(cacheable=false)
    public static String propertyLookupAPI(String reqBody){
        String endpoint = getEndpoint('propertyLookupAPI');
        String requestBody = reqBody;
        HttpResponse res = BatchLeadsCalloutAPI.calloutAPI(endpoint, requestBody);
        handleResponse(res);
        String responseBody = res.getBody();
        return responseBody;
    }
    
    @AuraEnabled(cacheable=false)
    public static String propertySearchAPI(String reqBody){
        String endpoint = getEndpoint('propertySearchAPI');
        String requestBody = reqBody;
        HttpResponse res = BatchLeadsCalloutAPI.calloutAPI(endpoint, requestBody);
        handleResponse(res);
        String responseBody = res.getBody();
        System.debug('BatchLead API response: ' + responseBody);
        return responseBody;
    }
    
    @AuraEnabled(cacheable=false)
    public static String propertySkipTraceAPI(String reqBody){
        String endpoint = getEndpoint('propertySkipTraceAPI');
        String requestBody = reqBody;
        HttpResponse res = BatchLeadsCalloutAPI.calloutAPI(endpoint, requestBody);
        handleResponse(res);
        String responseBody = res.getBody();
        return responseBody;
    }
    
    @AuraEnabled(cacheable=false)
    public static String propertyOwnerProfile(String reqBody){
        String endpoint = getEndpoint('propertyOwnerProfile');
        String requestBody = reqBody;
        HttpResponse res = BatchLeadsCalloutAPI.calloutAPI(endpoint, requestBody);
        handleResponse(res);
        String responseBody = res.getBody();
        return responseBody;
    }
    
    @AuraEnabled(cacheable=false)
    public static String phoneValidation(String reqBody){
        String endpoint = getEndpoint('phoneValidation');
        String requestBody = reqBody;
        HttpResponse res = BatchLeadsCalloutAPI.calloutAPI(endpoint, requestBody);
        handleResponse(res);
        String responseBody = res.getBody();
        return responseBody;
    }
    
    @AuraEnabled(cacheable=false)
    public static String phoneDNCStatus(String reqBody){
        String endpoint = getEndpoint('phoneDNCStatus');
        String requestBody = reqBody;
        HttpResponse res = BatchLeadsCalloutAPI.calloutAPI(endpoint, requestBody);
        handleResponse(res);
        String responseBody = res.getBody();
        return responseBody;
    }
    @AuraEnabled(cacheable=false)
    public static String phoneTCPAstatus(String reqBody){
        String endpoint = getEndpoint('phoneTCPAstatus');
        String requestBody = reqBody;
        HttpResponse res = BatchLeadsCalloutAPI.calloutAPI(endpoint, requestBody);
        handleResponse(res);
        String responseBody = res.getBody();
        return responseBody;
    }
    
    private static void handleResponse(HttpResponse res) {
        if (res.getStatusCode() == 200) {
            System.debug('BatchLead API response: ' + res.getBody());
        } else {
            String errorMessage = 'HTTP request failed with status ' + res.getStatus() + ': ' + res.getBody();
            System.debug('Error: ' + errorMessage);
//            throw new AuraHandledException(errorMessage);
        }
    }
}