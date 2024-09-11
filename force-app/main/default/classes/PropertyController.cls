public with sharing class PropertyController {
    
    @AuraEnabled
    public static void savePropertyDetails(String responseBody) {
        try{
            if(! String.isEmpty(responseBody) || !String.isBlank(responseBody)){ 
                Schema.RecordTypeInfo contactSellerRecordTypeInfo = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Property_Seller');                
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                Map<String, Object> results = (Map<String, Object>) responseMap.get('results');
                List<Object> propertyLst = (List<Object>) results.get('properties');
                List<Property__c> propertyDetails = new List<Property__c>();
                List<Contact> contactDetails = new List<Contact>();
                Map<String, Contact> ownerNameToContactMap = new Map<String, Contact>();
                if(!propertyLst.isEmpty()){
                    for (Object propertyObj : propertyLst) {
                        Map<String, Object> property = (Map<String, Object>) propertyObj;
                        Map<String, Object> general = (Map<String, Object>) property.get('general');
                        Map<String, Object> assessment = (Map<String, Object>) property.get('assessment');
                        Map<String, Object> propertyOwnerProfile = (Map<String, Object>) property.get('propertyOwnerProfile');
                        Map<String, Object> tax = (Map<String, Object>) property.get('tax');
                        Map<String, Object> valuation = (Map<String, Object>) property.get('valuation');
                        Map<String, Object> owner = (Map<String, Object>) property.get('owner');
                        Map<String, Object> address = (Map<String, Object>) property.get('address');
                        if (propertyObj != null) {
                            String propertyTypeCategory = (String) general.get('propertyTypeCategory') != null ? 
                                (String) general.get('propertyTypeCategory') : '' ;
                            String propertyTypeDetail = (String) general.get('propertyTypeDetail') != null ? 
                                (String) general.get('propertyTypeDetail') : '' ;
                            Integer landMarketValue = (Integer) assessment.get('landMarketValue') != null ? 
                                (Integer) assessment.get('landMarketValue'): 0;
                            Integer totalMarketValue = (Integer) assessment.get('totalMarketValue') != null ? 
                                (Integer) assessment.get('totalMarketValue') : 0;
                            Integer totalAssessedValue = (Integer) assessment.get('totalAssessedValue') != null ? 
                                (Integer) assessment.get('totalAssessedValue') : 0;
                            Integer propertiesTotalEstimatedValue = (Integer) propertyOwnerProfile.get('propertiesTotalEstimatedValue') != null ? 
                                (Integer) propertyOwnerProfile.get('propertiesTotalEstimatedValue') : 0 ;
                            Integer propertiesTotalEquity = (Integer) propertyOwnerProfile.get('propertiesTotalEquity') != null ? 
                                (Integer) propertyOwnerProfile.get('propertiesTotalEquity') : 0;
                            Integer totalPropertyCount = (Integer) propertyOwnerProfile.get('propertiesCount') != null ? 
                                (Integer) propertyOwnerProfile.get('propertiesCount'):0 ;
                            Integer taxAmount = (Integer) tax.get('taxAmount') != null ? (Integer) tax.get('taxAmount'):0 ;
                            Integer priceRangeMin = (Integer) valuation.get('priceRangeMin') != null ? (Integer) valuation.get('priceRangeMin'): 0;
                            Integer priceRangeMax = (Integer) valuation.get('priceRangeMax') != null ? (Integer) valuation.get('priceRangeMax'):0;
                            Integer confidenceScore = (Integer) valuation.get('confidenceScore') != null ? (Integer) valuation.get('confidenceScore'):0;
                            String addressStreet = (String) address.get('street') != null ? (String) address.get('street'):'';
                            String addressCity = (String) address.get('city') != null ? (String) address.get('city'):'';
                            String addressState = (String) address.get('state')!=null ? (String) address.get('state'):'';
                            String addressPostalCode = (String) address.get('zip')!=null ? (String) address.get('zip'):'';
                            
                            Property__c propertyDetail = new Property__c();
                            if (Schema.sObjectType.Property__c.fields.Property_Type_Category__c.isCreateable()) {
                                propertyDetail.Property_Type_Category__c = propertyTypeCategory;
                            }
                            if (Schema.sObjectType.Property__c.fields.Property_Type_Detail__c.isCreateable()) {
                                propertyDetail.Property_Type_Detail__c = propertyTypeDetail;
                            }
                            if (Schema.sObjectType.Property__c.fields.Land_Market_Value__c.isCreateable()) {
                                propertyDetail.Land_Market_Value__c = landMarketValue;
                            }
                            if (Schema.sObjectType.Property__c.fields.Total_Market_Value__c.isCreateable()) {
                                propertyDetail.Total_Market_Value__c = totalMarketValue;
                            }
                            if (Schema.sObjectType.Property__c.fields.Total_Estimated_Value__c.isCreateable()) {
                                propertyDetail.Total_Estimated_Value__c = propertiesTotalEstimatedValue;
                            }
                            if (Schema.sObjectType.Property__c.fields.Tax_Amount__c.isCreateable()) {
                                propertyDetail.Tax_Amount__c = taxAmount;
                            }
                            if (Schema.sObjectType.Property__c.fields.Price_Range_Max__c.isCreateable()) {
                                propertyDetail.Price_Range_Max__c = priceRangeMax;
                            }
                            if (Schema.sObjectType.Property__c.fields.Price_Range_Min__c.isCreateable()) {
                                propertyDetail.Price_Range_Min__c = priceRangeMin;
                            }
                            if (Schema.sObjectType.Property__c.fields.Property_Confidence_Score__c.isCreateable()) {
                                propertyDetail.Property_Confidence_Score__c = confidenceScore;
                            }
                            if (Schema.sObjectType.Property__c.fields.Property_Address_Street__c.isCreateable()) {
                                propertyDetail.Property_Address_Street__c = addressStreet;
                            }
                            if (Schema.sObjectType.Property__c.fields.Property_Address_City__c.isCreateable()) {
                                propertyDetail.Property_Address_City__c = addressCity;
                            }
                            if (Schema.sObjectType.Property__c.fields.Property_AddressState__c.isCreateable()) {
                                propertyDetail.Property_AddressState__c = addressState;
                            }
                            if (Schema.sObjectType.Property__c.fields.Property_Address_Postal_Code__c.isCreateable()) {
                                propertyDetail.Property_Address_Postal_Code__c = addressPostalCode;
                            }
                            
                            propertyDetails.add(propertyDetail);                            
                            if (owner != null) {
                                List<Object> ownerNames = (List<Object>) owner.get('names');
                                for (Object ownerNameObj : ownerNames) {
                                    Map<String, Object> ownerName = (Map<String, Object>) ownerNameObj;
                                    String ownerFirstName = (String) ownerName.get('first');
                                    String ownerLastName = (String) ownerName.get('last');
                                    String ownerFullName = ownerFirstName + ' ' + ownerLastName;
                                    
                                    if (!ownerNameToContactMap.containsKey(ownerFullName)) {
                                        Contact ownerDetail = new Contact();
                                        if (Schema.sObjectType.Contact.fields.FirstName.isCreateable()) {
                                            ownerDetail.FirstName = ownerFirstName;
                                        }
                                        if (Schema.sObjectType.Contact.fields.LastName.isCreateable()) {
                                            ownerDetail.LastName = ownerLastName;
                                        }
                                        if (Schema.sObjectType.Contact.fields.RecordTypeId.isCreateable()) {
                                            ownerDetail.RecordTypeId = contactSellerRecordTypeInfo.getRecordTypeId();
                                        }
                                        if (Schema.sObjectType.Contact.fields.Total_Assessed_Value__c.isCreateable()) {
                                            ownerDetail.Total_Assessed_Value__c = totalAssessedValue;
                                        }
                                        if (Schema.sObjectType.Contact.fields.Total_Property_Count__c.isCreateable()) {
                                            ownerDetail.Total_Property_Count__c = totalPropertyCount;
                                        }
                                        if (Schema.sObjectType.Contact.fields.Total_Equity__c.isCreateable()) {
                                            ownerDetail.Total_Equity__c = propertiesTotalEstimatedValue;
                                        }
                                        if (Schema.sObjectType.Contact.fields.Total_Estimated_Value__c.isCreateable()) {
                                            ownerDetail.Total_Estimated_Value__c = propertiesTotalEquity;
                                        }
                                        contactDetails.add(ownerDetail);
                                        ownerNameToContactMap.put(ownerFullName, ownerDetail);
                                    }
                                }
                            }
                        }
                    }
                    
                    if (!propertyDetails.isEmpty() && Schema.sObjectType.Property__c.isCreateable()) { 
                        insert propertyDetails;
                    }
                    
                    if (!contactDetails.isEmpty() && Schema.sObjectType.Contact.isCreateable()) {
                        insert contactDetails;                
                        for (Contact contactDetail : contactDetails) {
                            String ownerFullName = contactDetail.FirstName + ' ' + contactDetail.LastName;
                            ownerNameToContactMap.put(ownerFullName, contactDetail);
                        }
                    }
                    List<Property_Ownership__c> contactOwnershipDetails = new List<Property_Ownership__c>();
                    List<Deed_History__c> deedHistoryDetails = new List<Deed_History__c>();
                    List<Mortgage_History__c> mortgageHistoryDetails = new List<Mortgage_History__c>();
                    for (Property__c propertyDetail : propertyDetails) {
                        if (propertyDetail.Id != null) {
                            Map<String, Object> property = (Map<String, Object>) propertyLst[propertyDetails.indexOf(propertyDetail)];
                            Map<String, Object> owner = (Map<String, Object>) property.get('owner');
                            List<Object> deedHistory = (List<Object>) property.get('deedHistory');
                            List<Object> mortgageHistory = (List<Object>) property.get('mortgageHistory');
                            if (deedHistory != null) {
                                Integer deedHistoryLength = deedHistory.size();
                                for (Object deedObj : deedHistory) {
                                    Integer index = deedHistory.indexOf(deedObj);
                                    Map<String, Object> deed = (Map<String, Object>) deedObj;
                                    Deed_History__c deedHistoryDetail = new Deed_History__c();
                                    String recordingDateStr = (String) deed.get('recordingDate');
                                    String saleDateStr = (String) deed.get('saleDate');
                                    List<Object> buyersLst = (List<Object>) deed.get('buyers');
                                    List<Object> sellersLst = (List<Object>) deed.get('sellers');
                                    if (Schema.sObjectType.Deed_History__c.fields.Document_Type__c.isCreateable()) {
                                        deedHistoryDetail.Document_Type__c = (String) deed.get('documentType');
                                    }
                                    if (recordingDateStr!=null && Schema.sObjectType.Deed_History__c.fields.Recording_Date__c.isCreateable()){
                                        deedHistoryDetail.Recording_Date__c = Date.valueOf(recordingDateStr.substring(0, 10));
                                    }
                                    if (saleDateStr != null && Schema.sObjectType.Deed_History__c.fields.Sale_Date__c.isCreateable()) {
                                        deedHistoryDetail.Sale_Date__c = Date.valueOf(saleDateStr.substring(0, 10));
                                    }
                                    //deedHistoryDetail.Previous_Seller__c = contactDetails.
                                    if(Schema.sObjectType.Deed_History__c.fields.Property__c.isCreateable()){
                                        deedHistoryDetail.Property__c = propertyDetail.Id;
                                    }
                                    deedHistoryDetails.add(deedHistoryDetail);
                                }
                            }
                            if (mortgageHistory != null) {
                                for (Object mortgageObj : mortgageHistory) {
                                    Map<String, Object> mortgage = (Map<String, Object>) mortgageObj;
                                    Mortgage_History__c mortgageHistoryDetail = new Mortgage_History__c();
                                    if (Schema.sObjectType.Mortgage_History__c.fields.Interest_Rate__c.isCreateable()) {
                                        mortgageHistoryDetail.Interest_Rate__c = (Decimal) mortgage.get('interestRate');
                                    }
                                    if (Schema.sObjectType.Mortgage_History__c.fields.Loan_Amount__c.isCreateable()) {
                                        mortgageHistoryDetail.Loan_Amount__c = (Integer) mortgage.get('loanAmount');
                                    }
                                    if (Schema.sObjectType.Mortgage_History__c.fields.Loan_Term_Months__c.isCreateable()) {
                                        mortgageHistoryDetail.Loan_Term_Months__c = (Integer) mortgage.get('loanTermMonths');
                                    }
                                    String recordingDateStr = (String) mortgage.get('recordingDate');
                                    String saleDateStr = (String) mortgage.get('saleDate');
                                    String dueDateStr = (String) mortgage.get('dueDate');
                                    if(recordingDateStr!=null && Schema.sObjectType.Mortgage_History__c.fields.Recording_Date__c.isCreateable()){
                                        mortgageHistoryDetail.Recording_Date__c = Date.valueOf(recordingDateStr.substring(0, 10));
                                    }
                                    if (saleDateStr != null && Schema.sObjectType.Mortgage_History__c.fields.Sale_Date__c.isCreateable()) {
                                        mortgageHistoryDetail.Sale_Date__c = Date.valueOf(saleDateStr.substring(0, 10));
                                    }
                                    if (dueDateStr != null && Schema.sObjectType.Mortgage_History__c.fields.Due_Date__c.isCreateable()) {
                                        mortgageHistoryDetail.Due_Date__c = Date.valueOf(dueDateStr.substring(0, 10));
                                    }
                                    if (Schema.sObjectType.Mortgage_History__c.fields.Property__c.isCreateable()) {
                                        mortgageHistoryDetail.Property__c = propertyDetail.Id;
                                    }
                                    mortgageHistoryDetails.add(mortgageHistoryDetail);
                                }
                            }
                            if (owner != null) {
                                List<Object> ownerNames = (List<Object>) owner.get('names');
                                for (Object ownerNameObj : ownerNames) {
                                    Map<String, Object> ownerName = (Map<String, Object>) ownerNameObj;
                                    String ownerFirstName = (String) ownerName.get('first');
                                    String ownerLastName = (String) ownerName.get('last');
                                    String ownerFullName = ownerFirstName + ' ' + ownerLastName;
                                    if (ownerNameToContactMap.containsKey(ownerFullName)) {
                                        Property_Ownership__c contactOwnership = new Property_Ownership__c();
                                        if (Schema.sObjectType.Property_Ownership__c.fields.Property_Owner_Contact__c.isCreateable()) {
                                            contactOwnership.Property_Owner_Contact__c = ownerNameToContactMap.get(ownerFullName).Id;
                                        }
                                        if (Schema.sObjectType.Property_Ownership__c.fields.Property__c.isCreateable()) {
                                            contactOwnership.Property__c = propertyDetail.Id;
                                        }
                                        contactOwnershipDetails.add(contactOwnership);
                                    }
                                }
                            }
                        }
                    }
                    if (!contactOwnershipDetails.isEmpty() && Schema.sObjectType.Property_Ownership__c.isCreateable()) {
                        insert contactOwnershipDetails;
                    }
                    if (!deedHistoryDetails.isEmpty() && Schema.sObjectType.Deed_History__c.isCreateable()) {
                        insert deedHistoryDetails;
                    }
                    if (!mortgageHistoryDetails.isEmpty() && Schema.sObjectType.Mortgage_History__c.isCreateable()) {
                        insert mortgageHistoryDetails;
                    }
                }
            }
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}