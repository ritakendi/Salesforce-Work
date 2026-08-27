public class AccountUtils {
    public static List<Account>accountsByState(String abbreviatedState){
        List<Account> myAccounts = [SELECT Id, Name FROM Account WHERE BillingState =:abbreviatedState];
        return myAccounts;
    }
    public static List<Account> getAccountsByStatus(String status) {
        List<Account> myAccounts = [SELECT Name FROM Account WHERE Status__c = :status];
        return myAccounts;
    }

    public static Integer getContactCountByAccountId(Id accountId) {
        List<Contact> myContacts = [SELECT Id FROM Contact WHERE AccountId = :accountId];
        return myContacts.size();
    }

    public static Boolean isHighPriority(Account acc) {
        if (acc.CustomerPriority__c == 'High') {
            return true;
        }
        return false;
    }
}