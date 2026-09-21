public class RestCalloutPractice {
    public static void makeGetRequest() {
        // Create a new HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:HttpBin/get');
        req.setMethod('GET');
        // Send the request and receive the response
        Http http = new Http();
        HttpResponse res = http.send(req);
        // Check the response status code
        if (res.getStatusCode() == 200) {
            // Parse the JSON response
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            // Log the response
            System.debug('Response: ' + responseMap);
        } else {
            System.debug('Error: ' + res.getStatusCode() + ' - ' + res.getStatus());
        }
    }
}