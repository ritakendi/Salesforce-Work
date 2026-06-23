@isTest
public class ContactControllerTest {
    
    @testSetup
    // This method sets up test data by creating a test account and multiple test contacts associated with that account, which will be used in the subsequent test methods to verify the functionality of the ContactController class.
    static void testSetup() {
        // Create test account
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Create test contacts
        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            testContacts.add(new Contact(
                FirstName = 'Test',
                LastName = 'Contact ' + i,
                Email = 'contact' + i + '@example.com',
                Phone = '555-000' + i,
                AccountId = acc.Id
            ));
        }
        insert testContacts;
    }
    
    @isTest
    // This test verifies that the getContacts method returns a list of contacts with the expected number of records and that the contact fields are populated correctly.
    static void testGetContacts() {
        Test.startTest();
        List<Contact> contacts = ContactController.getContacts();
        Test.stopTest();
        
        System.assertNotEquals(null, contacts, 'Contacts should not be null');
        System.assertEquals(5, contacts.size(), 'Should retrieve 5 test contacts');
        
        // Verify contact fields are populated
        Contact firstContact = contacts[0];
        System.assertNotEquals(null, firstContact.Id, 'Contact Id should be populated');
        System.assertNotEquals(null, firstContact.FirstName, 'Contact FirstName should be populated');
        System.assertNotEquals(null, firstContact.LastName, 'Contact LastName should be populated');
    }
    
    @isTest
    // This test verifies that the getContacts method returns an empty list when there are no contacts in the system, ensuring that the method handles this edge case correctly.
    static void testGetContactsWithNoContacts() {
        // Delete all contacts
        List<Contact> allContacts = [SELECT Id FROM Contact];
        delete allContacts;
        
        Test.startTest();
        List<Contact> contacts = ContactController.getContacts();
        Test.stopTest();
        
        System.assertEquals(0, contacts.size(), 'Should return empty list when no contacts exist');
    }
    
    @isTest
    // This test verifies that the getContacts method correctly retrieves contacts along with their related account information, ensuring that the Account relationship is properly populated.
    static void testGetContactsIncludesAccountName() {
        Test.startTest();
        List<Contact> contacts = ContactController.getContacts();
        Test.stopTest();
        
        System.assertEquals(5, contacts.size(), 'Should have 5 contacts');

        // Verify that the related account information is included
        Contact firstContact = contacts[0];
        System.assertNotEquals(null, firstContact.Account, 'Related Account should be populated');
        System.assertEquals('Test Account', firstContact.Account.Name, 'Account Name should match');
        System.debug('firstContact: ' + firstContact);
    }
}