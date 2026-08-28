@isTest
public class ContactTriggerTest {
    @isTest
    static void testContactTrigger() {
        // Call the testdata factory to create Account and Contact records then insert
        Account account = TestDataFactory.createAccount();
        insert account;
        Contact contact = TestDataFactory.createContact();
        contact.AccountId = account.Id;

        Test.startTest();
        insert contact;
        contact.LastName = 'UpdatedLastName';
        update contact;
        delete contact;
        Test.stopTest();

        // Asssert Account.Number_Of_Contacts__c is updated correctly
        Account updatedAccount = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id = :account.Id];
        System.assertEquals(0, updatedAccount.Number_Of_Contacts__c, 'Number of Contacts should be 0 after deletion');  
    }

    @isTest 
    static void testAddingSecondContactUpdatesCount() {
        Account account = TestDataFactory.createAccount();
        insert account;

        Contact firstContact = TestDataFactory.createContact();
        firstContact.AccountId = account.Id;

        Test.startTest();
        insert firstContact;
        Contact secondContact = TestDataFactory.createContact();
        secondContact.AccountId = account.Id;
        insert secondContact;
        Test.stopTest();

        Account afterSecondInsert = [
            SELECT Number_Of_Contacts__c
            FROM Account
            WHERE Id = :account.Id
        ];

        System.assertEquals(
            2,
            afterSecondInsert.Number_Of_Contacts__c,
            'Account should have 2 Contacts after the second insert'
        );
    }
}