public with sharing class AccountTriggerHandler {

    // Trigger handler method to create opportunities when new accounts are created
    public static void CreateAccounts(List<Account> accs) {
        for (Account acc : accs) {
            if (acc.BillingState != null) {
                acc.ShippingState = acc.BillingState;
            }
        }
    }
}