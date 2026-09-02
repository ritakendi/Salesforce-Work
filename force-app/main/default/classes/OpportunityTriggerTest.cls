@isTest
public class OpportunityTriggerTest {
    @isTest
    static void testHighestAmountIsCopiedToNewOpportunity() {
        Opportunity existingOpp = new Opportunity(
            Name = 'Existing High Amount',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Discount__c = 2,
            Amount = 5000
        );
        insert existingOpp;

        Opportunity newOpp = new Opportunity(
            Name = 'New Opportunity',
            StageName = 'Prospecting',
            Discount__c = 2,
            CloseDate = Date.today().addDays(30),
            Amount = 2000
        );

        Test.startTest();
        insert newOpp;
        Test.stopTest();

        Opportunity savedOpp = [
            SELECT Current_Highest_Amount__c
            FROM Opportunity
            WHERE Id = :newOpp.Id
        ];

        System.assertEquals(
            5000,
            savedOpp.Current_Highest_Amount__c,
            'New Opportunity should display the highest existing Amount'
        );
    }
}