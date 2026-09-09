@isTest
public class ContactTriggerTest {
    @isTest
    static void testContactTrigger() {
        // Call the testdata factory to create Account and Contact records then insert
        Account account = TestDataFactory.createAccount();
        insert account;
        Contact contact = TestDataFactory.createContact(account.Id);
        contact.AccountId = account.Id;

        Test.startTest();
        insert contact;
        contact.LastName = 'UpdatedLastName';
        update contact;
        delete contact;
        Test.stopTest();

        Account updatedAccount = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id = :account.Id];
        System.assertEquals(0, updatedAccount.Number_Of_Contacts__c, 'Number of Contacts should be 0 after deletion');
    }

    @isTest
    static void testAddingSecondContactUpdatesCount() {
        Account account = TestDataFactory.createAccount();
        insert account;

        Contact firstContact = TestDataFactory.createContact(account.Id);
        firstContact.AccountId = account.Id;

        Test.startTest();
        insert firstContact;
        Contact secondContact = TestDataFactory.createContact(account.Id);
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
    @isTest
    static void testMoveContactBetweenAccounts() {
        Account firstAccount = TestDataFActory.createAccount();
        insert firstAccount;
        Account secondAccount = TestDataFactory.createAccount();
        insert secondAccount;

        Contact contact = TestDataFactory.createContact(firstAccount.Id);
        contact.AccountId = firstAccount.Id;
        insert contact;

        Test.startTest();
        contact.AccountId = secondAccount.Id;
        update contact;
        Test.stopTest();

        Account updatedFirstAccount = [
            SELECT Number_Of_Contacts__c
            FROM Account
            WHERE Id = :firstAccount.Id
        ];
        Account updatedSecondAccount = [
            SELECT Number_Of_Contacts__c
            FROM Account
            WHERE Id = :secondAccount.Id
        ];

        System.assertEquals(0, updatedFirstAccount.Number_Of_Contacts__c, 'First Account should have 0 Contacts after moving the Contact');
        System.assertEquals(1, updatedSecondAccount.Number_Of_Contacts__c, 'Second Account should have 1 Contact after moving the Contact');

    }

    @isTest static void testBulkUpdateContacts() {
        Account acc = testDataFactory.createAccount();
        insert acc;
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 200; i++) {
            contacts.add(testDataFactory.createContact(acc.Id));
        }
        insert contacts;
        Test.startTest();
        List<Contact> contactsToUpdate = [SELECT LastName FROM Contact WHERE AccountId = :acc.Id];
        for (Contact c : contactsToUpdate) {
            c.LastName = 'UpdatedLastName';
        }
        update contactsToUpdate;
        Test.stopTest();

        Account updatedAccount = [SELECT Number_Of_Contacts__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(200, updatedAccount.Number_Of_Contacts__c, 'Number of Contacts should be 200 after inserting 200 contacts');
    }
    @isTest static void testMovingContactToNullAccount() {
        Account acc = TestDataFactory.createAccount();
        insert acc;
        Contact contact = TestDataFactory.createContact(acc.Id);
        insert contact;

        Test.startTest();
        contact.AccountId = null;
        update contact;
        Test.stopTest();

        Account updatedAccount = [SELECT Number_Of_Contacts__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(0, updatedAccount.Number_Of_Contacts__c, 'Number of Contacts should be 0 after moving the Contact to null Account');
    }
}