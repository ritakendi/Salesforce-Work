public with sharing class InvocableExample {
    public class AccountDetailsWrapper {
        @invocableVariable(required = true)
        public Id accountId;
        
        @invocableVariable
        public String status;
    }
    @invocableMethod(label='Update Account Status' description='Updates the status of accounts')
    public static void updateAccountStatus(List<AccountDetailsWrapper> accountDetailsList) {
    List<Account> accountsToUpdate = new List<Account>();
        for (AccountDetailsWrapper accDetails : accountDetailsList) {
            Account acc = new Account(Id = accDetails.accountId, Status__c = accDetails.status);
            accountsToUpdate.add(acc);
        }
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}