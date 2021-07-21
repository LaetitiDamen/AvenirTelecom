@isTest
public with sharing class TestDataFromSource {
    @isTest
    public static void TestDataFromSource() {
        // Test data setup
        // Create an lead 
        Lead objLead = new Lead (LastName = 'Test', Email = 'test@gmail.com', mobilephone = '+1234567890', Company = 'Test company', Offer = 'Millenium');
        insert objLead; 
        
        // Perform test
		Test.startTest();
	    objLead = new Lead (LastName = 'Test data', Email = 'test@gmail.com', mobilephone = '+1234567890', Company = 'Test company', Offer = 'Millenium');
        Database.SaveResult result = Database.insert(objLead, false);
        
        // Verify 
		System.assert(result.getErrors()[0].getMessage().contains('Lead already exist with this'));
		Test.stopTest();

    }
}
