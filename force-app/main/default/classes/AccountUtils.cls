public class AccountUtils {
    public static List<Account>accountsByState(String abbreviatedState){
        return [SELECT Id, Name FROM Account WHERE Country_Code__c =:abbreviatedState];
    }
    public static List<Account> getAccountsByStatus(String status) {
        return [SELECT Id, Name FROM Account WHERE Status__c = :status];
    }

    public static Integer getContactCountByAccountId(Id accountId) {
        return [SELECT COUNT() FROM Contact WHERE AccountId = :accountId];
    }

    public static Boolean isHighPriorityAccount(Id accountId) {
        Account acc = [SELECT CustomerPriority__c FROM Account WHERE Id = :accountId LIMIT 1];
        if (acc.CustomerPriority__c == 'High') {
            return true;
        }
        return false;
    }
}