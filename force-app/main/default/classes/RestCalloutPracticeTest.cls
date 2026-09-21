@isTest
private class RestCalloutPracticeTest {
    private class GetResponseMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            System.assertEquals('GET', request.getMethod());
            System.assertEquals('callout:HttpBin/get', request.getEndpoint());

            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"args":{},"url":"https://httpbin.org/get"}');

            return response;
        }
    }

    @IsTest
    static void testGetRequest() {
        Test.setMock(HttpCalloutMock.class, new GetResponseMock());

        Test.startTest();
        RestCalloutPractice.makeGetRequest();
        Test.stopTest();
    }
}