@isTest
private class AccountTriggerTest {

    @isTest
    static void TestCreateNewAccountInBulk() {

        List<Account> accts = new List<Account>();
        for (Integer i = 0; i < 200; i++) {
            accts.add(new Account(
                Name = 'Test Account ' + i,
                BillingState = 'CA'
            ));
        }

        Test.startTest();
        insert accts;
        Test.stopTest();

        List<Account> verifyAccts = [
            SELECT ShippingState FROM Account
        ];
        System.debug('verifyAccts' + verifyAccts);

        System.assertEquals(200, verifyAccts.size());

        for (Account acc : verifyAccts) {
            System.assertEquals('CA', acc.ShippingState);
        }
    }
}