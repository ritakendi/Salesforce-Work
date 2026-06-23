@isTest
private class ApplicationTriggerHandlerTest {
    private static Id getRecordTypeId(String developerName) {
        return Application__c.SObjectType
            .getDescribe()
            .getRecordTypeInfosByDeveloperName()
            .get(developerName)
            .getRecordTypeId();
    }
    
    @isTest static void testUndergraduateFee() {
        Application__c app = new Application__c(
            Name = 'Test Undergraduate',
            RecordTypeId = getRecordTypeId('Undergraduate')
        );
        insert app;
        
        app = [ 
            SELECT Application_Fee__c FROM Application__c WHERE Id =:app.Id
        ];
        
        System.assertEquals(1000, app.Application_Fee__c);
    }
    @isTest static void testpostgraduateFee() {
        Application__c app = new Application__c(
            Name = 'Test Postgraduate',
            RecordTypeId = getRecordTypeId('Postgraduate')
        );
        insert app;
        
        app = [ 
            SELECT Application_Fee__c FROM Application__c WHERE Id =:app.Id
        ];
        
        System.assertEquals(2000, app.Application_Fee__c);
    }
}