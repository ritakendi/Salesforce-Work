public with sharing class AccountTriggerHandler {

    public static void CreateAccounts(List<Account> accs) {
        for (Account acc : accs) {
            if (acc.BillingState != null) {
                acc.ShippingState = acc.BillingState;
            }
        }
    }
}