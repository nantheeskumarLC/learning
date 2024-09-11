@isTest
public class PropertyControllerTest {
    
    
    @isTest
    static void testSavePropertyDetails_Success() {        
        try{
            String responseBody = '{ "results": { "properties": [ { "general": { "propertyTypeCategory": "Residential", "propertyTypeDetail": "Single Family" }, "assessment": { "landMarketValue": 100000, "totalMarketValue": 200000, "totalAssessedValue": 150000 }, "propertyOwnerProfile": { "propertiesTotalEstimatedValue": 250000, "propertiesTotalEquity": 50000, "propertiesCount": 3 }, "tax": { "taxAmount": 2500 }, "valuation": { "priceRangeMin": 180000, "priceRangeMax": 220000, "confidenceScore": 95 }, "address": { "street": "123 Main St", "city": "Springfield", "state": "IL", "zip": "62701" }, "owner": { "names": [ { "first": "John", "last": "Doe" } ] }, "deedHistory": [ { "documentType": "Corporation Deed", "recordingDate": "2023-01-01T00:00:00Z", "saleDate": "2023-01-02T00:00:00Z", "buyers": [ "John Doe" ], "sellers": [ "Jane Doe" ] } ], "mortgageHistory": [ { "interestRate": 3.5, "loanAmount": 150000, "loanTermMonths": 360, "recordingDate": "2023-01-03T00:00:00Z", "saleDate": "2023-01-04T00:00:00Z", "dueDate": "2053-01-01T00:00:00Z" } ] } ] } }';
            Test.startTest();
            PropertyController.savePropertyDetails(responseBody);
            Test.stopTest(); 
            
            Property__c property = new Property__c();
            property.Property_Type_Category__c = 'Residential';
            property.Property_Type_Detail__c = 'Single Family';
            insert property;
            
            List<Property__c> properties = [SELECT Property_Type_Category__c, Property_Type_Detail__c FROM Property__c where Id = :property.Id];
            System.assertEquals(1, properties.size());
            System.assertEquals('Residential', properties[0].Property_Type_Category__c);
            System.debug('propertyTypeCategory:::::'+properties[0].Property_Type_Category__c);
            System.assertEquals('Single Family', properties[0].Property_Type_Detail__c);
            System.debug('properties'+ properties[0]);
            
            Schema.RecordTypeInfo contactSellerRecordTypeInfo = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Property_Seller');                
            Contact contact = new Contact();
            contact.FirstName = 'John';
            contact.LastName = 'Doe';
            contact.RecordTypeId = contactSellerRecordTypeInfo.getRecordTypeId();
            insert contact;
            
            List<Contact> contacts = [SELECT FirstName, LastName, RecordTypeId FROM Contact where Id =: contact.Id];
            System.assertEquals(1, contacts.size());
            System.assertEquals('John', contacts[0].FirstName);
            System.assertEquals('Doe', contacts[0].LastName);
            System.assertEquals(Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Property_Seller').getRecordTypeId(), contacts[0].RecordTypeId);
            
            Property_Ownership__c propertyOwner = new Property_Ownership__c();
            propertyOwner.Property_Owner_Contact__c = contacts[0].Id ;
            propertyOwner.Property__c = properties[0].Id;
            insert propertyOwner;
            List<Property_Ownership__c> ownerships = [SELECT Property__c, Property_Owner_Contact__c FROM Property_Ownership__c where Id =:propertyOwner.Id];
            System.assertEquals(1, ownerships.size());
            System.assertEquals(properties[0].Id, ownerships[0].Property__c);
            System.assertEquals(contacts[0].Id, ownerships[0].Property_Owner_Contact__c);
            
            Deed_History__c propertyDeed = new Deed_History__c();
            propertyDeed.Document_Type__c = 'Corporation Deed';
            propertyDeed.Recording_Date__c = Date.valueOf('2023-01-01');
            propertyDeed.Sale_Date__c = Date.valueOf('2023-01-02');
            propertyDeed.Property__c = properties[0].Id;
            insert propertyDeed;
            
            List<Deed_History__c> deeds = [SELECT Id, Document_Type__c, Recording_Date__c, Sale_Date__c, Property__c FROM Deed_History__c where Id =:propertyDeed.Id];
            System.assertEquals(1, deeds.size());
            System.assertEquals('Corporation Deed', deeds[0].Document_Type__c);
            System.assertEquals(Date.valueOf('2023-01-01'), deeds[0].Recording_Date__c);
            System.assertEquals(Date.valueOf('2023-01-02'), deeds[0].Sale_Date__c);
            System.assertEquals(properties[0].Id , deeds[0].Property__c);
            
            Mortgage_History__c propertyMortgage = new Mortgage_History__c();
            propertyMortgage.Interest_Rate__c = 3.5;
            propertyMortgage.Loan_Amount__c = 150000;
            propertyMortgage.Loan_Term_Months__c = 360;
            propertyMortgage.Property__c = properties[0].Id;
            insert propertyMortgage;
            
            List<Mortgage_History__c> mortgages = [SELECT Id, Interest_Rate__c, Loan_Amount__c, Loan_Term_Months__c, Property__c FROM Mortgage_History__c where Id= :propertyMortgage.Id];
            System.assertEquals(1, mortgages.size());
            System.assertEquals(3.5, mortgages[0].Interest_Rate__c);
            System.assertEquals(150000, mortgages[0].Loan_Amount__c);
            System.assertEquals(360, mortgages[0].Loan_Term_Months__c);
            System.assertEquals(properties[0].Id , mortgages[0].Property__c);
        }
        catch (Exception e) {
            System.assertEquals('Error saving property details: Invalid or empty response', e.getMessage());
        }
    }
}