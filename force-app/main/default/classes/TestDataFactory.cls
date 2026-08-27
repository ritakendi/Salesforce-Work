@isTest
public class TestDataFactory { 
    public static Account createAccount() {
        return new Account(
            Name = 'Test Account',
            Country_Code__c = 'KE'
        );
    }
    public static Contact createContact() {
        return new Contact(
            LastName = 'Test Contact',
            AccountId = createAccount().Id
        );
    }
}