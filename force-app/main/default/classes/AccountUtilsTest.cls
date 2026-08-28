@isTest
public class AccountUtilsTest {
    @isTest static void tesAccountsByState() {
        Account testAccount = TestDataFactory.createAccount();
        insert testAccount;
        List<Account> myAccounts = AccountUtils.accountsByState('KE');
        System.assertEquals(myAccounts.size(), 1);
        System.assertEquals(myAccounts[0].Name, 'Test Account');
    }
    @istest static void testGetAccountsByStatus() {
        Account testAccount = TestDataFactory.createAccount();
        insert testAccount;

        Test.startTest();
        List<Account> myAccounts = AccountUtils.getAccountsByStatus('Inactive');
        Test.stopTest();

        System.assertEquals(myAccounts.size(), 1);
        System.assertEquals(myAccounts[0].Name, 'Test Account');
    }
    @istest static void testGetContactCountByAccountId() {
        Account testAccount = TestDataFactory.createAccount();
            insert testAccount;

        Contact testContact = TestDataFactory.createContact();
        insert testContact;

        Test.startTest();
        Integer contactCount = AccountUtils.getContactCountByAccountId(testAccount.Id);
        Test.stopTest();

        System.assertEquals(contactCount, 1);
    }
}