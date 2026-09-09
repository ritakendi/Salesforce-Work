public class ContactTriggerHandler {
    // we need a set of Accounts for affected Accounts
    public static void handleContactChanges(
        List<Contact> newContacts,
        Map<Id, Contact> oldContactsMap,
        Boolean isDelete,
        Boolean isUpdate
    )
        {
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
                    if (isUpdate && oldContactsMap.containsKey(newContact.Id)) {
                        Contact oldContact = oldContactsMap.get(newContact.Id);
                        if (oldContact.AccountId != newContact.AccountId) {
                            if (oldContact.AccountId != null) {
                                affectedAccountIds.add(oldContact.AccountId);
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