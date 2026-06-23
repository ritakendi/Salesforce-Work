public class ApplicationTriggerHandler {
    public static void setFees(List<Application__c> applications){
        Id undergradRtId = Application__c.SObjectType
            .getDescribe()
            .getRecordTypeInfosByDeveloperName()
            .get('Undergraduate')
            .getRecordTypeId();
		Id postgradRtId = Application__c.SObjectType
            .getDescribe()
            .getRecordTypeInfosByDeveloperName()
            .get('Postgraduate')
            .getRecordTypeId();
        
        for(Application__c app : applications){
            if(app.RecordTypeId == undergradRtId){
                app.Application_Fee__c = 1000;
            }
            else if (app.RecordTypeId == postgradRtId){
                app.Application_Fee__c = 2000;
            }
        } 
    }
}