public class AccountUtils {
    public static List<Account>accountsByState(String abbreviatedState){
        return [SELECT Id, Name FROM Account WHERE BillingState =:abbreviatedState];
    }
    public static List<Account> getAccountsByStatus(String status) {
        return [SELECT Id, Name FROM Account WHERE Status__c = :status];
    }

    public static Integer getContactCountByAccountId(Id accountId) {
        return [SELECT COUNT() FROM Contact WHERE AccountId = :accountId];
    }

    public static Boolean isHighPriority(Account acc) {
        if (acc.CustomerPriority__c == 'High') {
            return true;
        }
        return false;
    }
}