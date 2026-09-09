@isTest
public class AccountUtilsTest {
    @isTest static void tesAccountsByState() {
        Account testAccount = TestDataFactory.createAccount();
        insert testAccount;
        List<Account> myAccounts = AccountUtils.accountsByState('KE');
        System.assertEquals(1, myAccounts.size());
        System.assertEquals('Test Account', myAccounts[0].Name);
    }
    @istest static void testGetAccountsByStatus() {
        Account testAccount = TestDataFactory.createAccount();
        insert testAccount;

        Test.startTest();
        List<Account> myAccounts = AccountUtils.getAccountsByStatus('Active');
        Test.stopTest();

        System.assertEquals(1, myAccounts.size());
        System.assertEquals('Test Account', myAccounts[0].Name);
    }
    @istest static void testGetContactCountByAccountId() {
        Account testAccount = TestDataFactory.createAccount();
        insert testAccount;
        Contact testContact = TestDataFactory.createContact(testAccount.Id);
        insert testContact;

        Test.startTest();
        Integer contactCount = AccountUtils.getContactCountByAccountId(testContact.AccountId);
        Test.stopTest();

        System.assertEquals(1, contactCount);
    }
    @isTest static void testisHighPriorityAccount() {
        Account testAccount = TestDataFactory.createAccount();
        testAccount.CustomerPriority__c = 'High';
        insert testAccount;

        Test.startTest();
        Boolean isHighPriority = AccountUtils.isHighPriorityAccount(testAccount.Id);
        Test.stopTest();

        System.assertEquals(true, isHighPriority);

        //Test with a non-high priority account
        testAccount.CustomerPriority__c = 'Low';
        update testAccount;
        isHighPriority = AccountUtils.isHighPriorityAccount(testAccount.Id);
        System.assertEquals(false, isHighPriority);
    }
}