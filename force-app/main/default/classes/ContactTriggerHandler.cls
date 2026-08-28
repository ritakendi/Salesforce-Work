public class ContactTriggerHandler {
    // we need a set of Accounts for affected Accounts
    public static void handleContactChanges(List<Contact> newContacts, Map<Id, Contact> oldContactsMap, Boolean isDelete) {
        // we need a set of Accounts for affected Accounts
        Set <Id> affectedAccountIds = new Set<Id>();
        if (isDelete) {
            for (Contact oldContact : oldContactsMap.values()) {
                if (oldContact.AccountId != null) {
                    affectedAccountIds.add(oldContact.AccountId);
                }
            }
        } else {
            for (Contact newContact : newContacts) {
                if (newContact.AccountId != null){
                    affectedAccountIds.add(newContact.AccountId);
                }
                // we can also check if the AccountId has changed in an update store both old and new AccountId in the set of affected AccountIds
                if (oldContactsMap != null && oldContactsMap.containsKey(newContact.Id)) {
                    Contact oldContact = oldContactsMap.get(newContact.Id);
                    if (oldContact.AccountId != newContact.AccountId) {
                        if (oldContact.AccountId != null) {
                            affectedAccountIds.add(oldContact.AccountId);
                        }
                        if (newContact.AccountId != null) {
                            affectedAccountIds.add(newContact.AccountId);
                        } 
                    }
                }
            }
        }        
        if (!affectedAccountIds.isEmpty()) {
            AccountProcessor.countContacts(new List<Id>(affectedAccountIds));
        }
    } 
}