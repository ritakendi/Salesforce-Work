@isTest
public class AccountProcessorTest {
    @isTest public static void testContactNumber(){
        Account acc = new Account(
            Name = 'Rita'  
        );
        insert acc;
        
        Contact con = new Contact(
            LastName = 'Shui',
            AccountId = acc.Id
        );
         insert con;
        //Run future method
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{acc.Id});
        Test.stopTest();

        //Verify results
		Account updatedAcc = [
            SELECT Number_Of_Contacts__c
            FROM Account
        	WHERE Id = :acc.Id];
        
        System.assertEquals(
            1,
            updatedAcc.Number_Of_Contacts__c,
            'Account should have 1 related Contact'
        );
    }
    @isTest static void testAccountWithNoContacts() {
        // Create Account with NO Contacts
        Account acc = new Account(Name = 'No Contacts');
        insert acc;
    
        Test.startTest();
        AccountProcessor.countContacts(
            new List<Id>{ acc.Id }
        );
        Test.stopTest();
    
        Account updatedAcc = [
            SELECT Number_Of_Contacts__c
            FROM Account
            WHERE Id = :acc.Id
        ];
    
        System.assertEquals(
            0,
            updatedAcc.Number_Of_Contacts__c,
            'Account with no Contacts should have count 0'
        );
    }

}