@isTest
public class ContactTriggerTest {
    @isTest
    static void testContactTrigger() {
        // Call the testdata factory to create Account and Contact records
        List<Account> accounts = TestDataFactory.createAccounts(1);
        List<Contact> contacts = TestDataFactory.createContacts(accounts[0].Id, 1);

        // Perform DML operations to trigger the ContactTrigger
        Test.startTest();
        // Update the Contact to trigger after update
        contacts[0].LastName = 'UpdatedLastName';
        update contacts[0];
        // Delete the Contact to trigger after delete
        delete contacts[0];
        Test.stopTest();

        // Asssert Account.Number_Of_Contacts__c is updated correctly
        Account updatedAccount = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id = :accounts[0].Id];
        System.assertEquals(0, updatedAccount.Number_Of_Contacts__c, 'Number of Contacts should be 0 after deletion');  
    }
}