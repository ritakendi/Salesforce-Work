@isTest
public class LeadProcessorTest {
    @testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        //insert 200 lead records
        for (integer i=0; i<200; i++){
            leads.add(new Lead(LastName = 'Lead '+ i ,Company= 'Idle'));
        }
        insert leads;
    }
    @isTest static void test(){
        Test.startTest();
        LeadProcessor lps = new LeadProcessor();
        Id batchId = Database.executeBatch(lps);
        Test.stopTest();
        system.assertEquals(200, [SELECT count() from Lead WHERE LeadSource = 'Dreamforce']);
    }

}