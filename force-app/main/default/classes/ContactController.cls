public with sharing class ContactController {
    
    /**
     * Retrieves a list of all contacts with essential fields for display
     * @return List of Contact records containing Id and name fields
     */
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        try {
            List<Contact> contacts = [
                SELECT Id, FirstName, LastName, Email, Phone, AccountId, Account.Name
                FROM Contact
                WITH SECURITY_ENFORCED
                ORDER BY FirstName, LastName
                LIMIT 1000
            ];
            return contacts;
        } catch (Exception e) {
            throw new AuraHandledException('Error retrieving contacts: ' + e.getMessage());
        }
    }
}