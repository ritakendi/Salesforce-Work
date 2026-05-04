@isTest
public class PlatformEventTest {
    @isTest static void test1() {
        // Create test event instance
        Cloud_News__e newsEvent = new Cloud_News__e(
        Location__c = 'Mountain City',
        Urgent__c = true,
        News_content__c = 'Test message.');
        Test.startTest();
        // call method to publish events
        Database.saveResult sr = EventBus.publish(newsEvent);
        Test.stopTest();
        // Verify that the publish was successful.
        System.assertEquals(true, sr.isSuccess());
        // check that the case that the trigger created is present
        List<case> cases = [SELECT Id FROM case];
        //validate the case was found
        System.assertEquals(1, cases.size());
    }
}