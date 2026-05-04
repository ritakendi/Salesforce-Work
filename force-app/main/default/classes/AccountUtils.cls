public class AccountUtils {
    public static List<Account>accountsByState(String abbreviatedState){
        List<Account> myAccounts = [SELECT Id, Name FROM Account WHERE BillingState =:abbreviatedState];
        return myAccounts;
    }
}