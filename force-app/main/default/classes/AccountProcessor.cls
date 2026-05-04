public class AccountProcessor {

    @future
    public static void countContacts(List<Id> accountIds){
       // Map to store contact counts per Account
       Map<Id, Integer> contactCountMap = new Map<Id, Integer>();

        // Aggregate query to count contacts per Account
        for (AggregateResult ar : [
            SELECT AccountId accId, count(Id) total 
            FROM Contact 
            WHERE AccountId=:accountIds
        	GROUP BY AccountId
        ]) {
            contactCountMap.put(
            (Id) ar.get('accId'),
            (Integer) ar.get('total')
            );
        }
        //Prepare Accounts for Update
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : accountIds){
            Integer count = contactCountMap.containsKey(accId)
                ? contactCountMap.get(accId)
                : 0;
            
            accountsToUpdate.add(
            	new Account(
         			Id = accId,
                	Number_Of_Contacts__c = count
                )
            );
        }
        //Save changes 
        update accountsToUpdate;
    }
}