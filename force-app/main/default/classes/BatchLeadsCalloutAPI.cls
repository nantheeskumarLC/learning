public with sharing class BatchLeadsCalloutAPI {
    
	private static final String accessToken = Label.API_Access_Token;
    
    public static HttpResponse calloutAPI(String endpoint , String requestBody){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setBody(requestBody);
        System.debug('requestBody---->'+ requestBody);
        
         Http http = new Http();
        HttpResponse res = http.send(req);
        return res;
    }

}