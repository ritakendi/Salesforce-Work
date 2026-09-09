@isTest
public class TestDataFactory { 
    public static Account createAccount() {
        return new Account(
            Name = 'Test Account',
            Country_Code__c = 'KE'
        );
    }
    public static Contact createContact(Id accountId) {
        return new Contact(
            LastName = 'Test Contact',
            AccountId = accountId
        );
    }
}