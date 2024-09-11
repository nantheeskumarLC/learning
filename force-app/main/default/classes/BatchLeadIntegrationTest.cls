@IsTest
public class BatchLeadIntegrationTest {
    
    private static SingleRequestMock setupSuccessMock() {
        Integer statusCode = 200;
        String status = 'OK';
        String body = '{ "success": true,"status": { "code": 200, "text": "OK" }, "results": { "properties": [ { "_id": "76ef71f2bc0c999e87592cd8302c5d32", "address": { "houseNumber": "26823", "street": "26823 N 31st Dr", "city": "Phoenix", "cityAliases": [ "phoenix" ], "county": "Maricopa", "state": "AZ", "zip": "85083", "zipPlus4": "5837", "formattedStreet": "N 31st Dr", "streetNoUnit": "26823 N 31st Dr", "localities": [ "arizona hillcrest" ], "latitude": 33.728785, "longitude": -112.126019, "countyFipsCode": "04013", "hash": "fae16e6adfaf0bb0f306ba89bf7b4c1e", "normalized": true, "geoStatus": "Rooftop", "geoStatusCode": "A", "oldHashes": [ "7177db006a251744584837919a7d4d4a", "fae16e6adfaf0bb0f306ba89bf7b4c1e" ] }, "assessment": { "assessedImprovementValue": 27730, "assessedLandValue": 6930, "totalAssessedValue": 43300, "assessmentYear": 2024, "improvementMarketValue": 346400, "landMarketValue": 86600, "totalMarketValue": 433000, "marketValueYear": 2024 }, "building": { "totalBuildingAreaSquareFeet": 1761, "totalBuildingAreaCode": "B", "totalBuildingAreaCodeDescription": "Living Area", "livingAreaSquareFeet": 1761, "yearBuilt": 2001, "effectiveYearBuilt": 2001, "buildingCount": 1, "roomCount": 6, "unitCount": 1, "calculatedBathroomCount": 2, "fullBathroomCount": 2, "bathroomCount": 2, "bathFixtureCount": 7, "storyCount": 1, "garageParkingSpaceCount": 2, "residentialUnitCount": 1, "features": [ "Air Conditioning", "Refrigeration Air Conditioning", "Sauna/Steam Room", "Koi Pond", "Mobile Home Hookup", "Patio", "Garage", "Pool", "Elevator" ], "airConditioningSourceCode": "J", "airConditioningSource": "Refrigeration", "buildingConditionCode": "F", "buildingCondition": "Average", "buildingQualityCode": "D", "buildingQuality": "B", "constructionTypeCode": "C", "constructionType": "Frame", "exteriorWallsCode": "S", "exteriorWalls": "Stucco", "garageCode": "I", "garage": "Garage", "heatSourceCode": "X", "heatSource": "Yes", "patioCode": "A", "patio": "Patio", "poolCode": "H", "pool": "Pool - Yes", "roofCoverCode": "I", "roofCover": "Concrete", "fireplaceCount": 0 }, "deedHistory": [ { "buyers": [ "KB HOME SALES PHOENIX INC" ], "sellers": [ "KB HOME PHOENIX INC", "KAUFMAN & BROAD OF ARIZONA INC" ], "recordingDate": "2001-07-30T00:00:00.000Z", "saleDate": "2001-07-20T00:00:00.000Z", "documentNumber": "2001-0688814", "documentTypeCode": "Z", "documentType": "Corporation Deed", "salePrice": 0 }, { "buyers": [ "CHENEY RHONDA" ], "sellers": [ "NUNEZ JR ROBERTO" ], "recordingDate": "2002-08-30T00:00:00.000Z", "saleDate": "2002-08-19T00:00:00.000Z", "documentNumber": "2002-0890956", "documentTypeCode": "BF", "documentType": "Quit Claim Deed", "salePrice": 0 }, { "buyers": [ "ANDERSON RHONDA K" ], "sellers": [ "ANDERSON KYLE DOUGLAS" ], "recordingDate": "2005-01-20T00:00:00.000Z", "saleDate": "2005-01-14T00:00:00.000Z", "documentNumber": "2005-0080877", "documentTypeCode": "AQ", "documentType": "Intra-Family Transfer", "salePrice": 0, "interFamily": true }, { "buyers": [ "ANDERSON RHONDA K" ], "sellers": [ "ANDERSON RHONDA K", "CHENEY RHONDA" ], "recordingDate": "2005-01-20T00:00:00.000Z", "saleDate": "2005-01-14T00:00:00.000Z", "documentNumber": "2005-0080876", "documentTypeCode": "AQ", "documentType": "Intra-Family Transfer", "salePrice": 0, "interFamily": true }, { "buyers": [ "ANDERSON KYLE", "ANDERSON RHONDA K" ], "sellers": [], "recordingDate": "2006-12-29T00:00:00.000Z", "saleDate": "2006-12-11T00:00:00.000Z", "documentNumber": "2006-1700576", "documentTypeCode": "DN", "documentType": "Stand Alone Mortgage" }, { "buyers": [ "ANDRESON RHONDA K", "ANDERSON KYLE" ], "sellers": [ "ANDRESON RHONDA K", "ANDRESON KYLE" ], "recordingDate": "2013-01-18T00:00:00.000Z", "saleDate": "2012-11-13T00:00:00.000Z", "documentNumber": "2013-0056003", "documentTypeCode": "AQ", "documentType": "Intra-Family Transfer", "salePrice": 0, "interFamily": true } ], "demographics": {}, "foreclosure": {}, "general": { "carrierRoute": "R087", "vacant": false, "mailingAddressVacant": false, "standardizedLandUseCode": "R2", "propertyTypeCategory": "Residential", "propertyTypeDetail": "Single Family", "congressionalDistrict": "08", "timeZone": "Mountain", "utcOffset": -7, "daylightSavingsTime": false, "censusTract": "040136119.001008", "primaryParcel": true, "parcelCount": 1 }, "ids": { "addressHash": "fae16e6adfaf0bb0f306ba89bf7b4c1e", "apn": "205-03-224", "oldApn": "205032242", "fipsCode": "04013" }, "legal": { "assessorsMapReference": "MB 51824", "cityTownshipMunicipality": "Phoenix", "legalDescription": "ARIZONA HILLCREST MCR 518-24", "lotCode": "S", "lotNumber": "199", "sectionTownshipRangeMeridian": "SEC 35 TWN 5N RNG 2E", "subdivisionName": "ARIZONA HILLCREST", "tractNumber": "ARIZONA HILLCREST" }, "lot": { "lotSizeAcres": 0.14637281910009184, "lotSizeSquareFeet": 6376, "zoningCode": "R-8" }, "mls": { "brokerage": {}, "agents": {} }, "mortgageHistory": [ { "borrowers": [ "CHENEY RHONDA" ], "saleDate": "2002-08-19T00:00:00.000Z", "recordingDate": "2002-08-30T00:00:00.000Z", "dueDate": "2032-09-01T00:00:00.000Z", "lenderName": "CAPITOL COMMERCE MTG CO", "loanAmount": 160500, "loanTermMonths": 360, "interestRate": 6.43 }, { "borrowers": [ "ANDERSON RHONDA K" ], "saleDate": "2005-01-14T00:00:00.000Z", "recordingDate": "2005-01-20T00:00:00.000Z", "dueDate": "2035-02-01T00:00:00.000Z", "lenderName": "JPMORGAN CHASE BANK NA", "loanTypeCode": "AH", "loanType": "Unknown (DEFAULT)", "loanAmount": 156800, "loanTermMonths": 360, "interestRate": 5.67 }, { "borrowers": [ "ANDERSON RHONDA K" ], "saleDate": "2005-01-14T00:00:00.000Z", "recordingDate": "2005-01-20T00:00:00.000Z", "dueDate": "2035-01-28T00:00:00.000Z", "lenderName": "JPMORGAN CHASE BANK NA", "loanTypeCode": "K", "loanType": "Credit Line (Revolving)", "loanAmount": 19000, "loanTermMonths": 360, "interestRate": 5.67 }, { "borrowers": [ "ANDERSON KYLE", "ANDERSON RHONDA K" ], "saleDate": "2006-12-11T00:00:00.000Z", "recordingDate": "2006-12-29T00:00:00.000Z", "dueDate": "2026-12-19T00:00:00.000Z", "lenderName": "USAA FSB", "loanTypeCode": "K", "loanType": "Credit Line (Revolving)", "loanAmount": 75299, "loanTermMonths": 240, "interestRate": 6.33 }, { "borrowers": [ "ANDRESON RHONDA K", "ANDERSON KYLE" ], "saleDate": "2012-11-13T00:00:00.000Z", "recordingDate": "2013-01-18T00:00:00.000Z", "dueDate": "2027-12-01T00:00:00.000Z", "lenderName": "USAA FSB", "loanTypeCode": "U", "loanType": "New Conventional", "loanAmount": 112000, "loanTermMonths": 180, "interestRate": 3.31 } ], "openLien": { "allLoanTypes": [], "juniorLoanTypes": [], "totalOpenLienCount": 0, "mortgages": {} }, "owner": { "fullName": "Kyle Anderson; Rhonda K Anderson", "mailingAddress": { "houseNumber": "26823", "street": "26823 N 31st Dr", "city": "Phoenix", "county": "Maricopa", "state": "AZ", "zip": "85083", "zipPlus4": "5837", "formattedStreet": "N 31st Dr", "streetNoUnit": "26823 N 31st Dr", "hash": "fae16e6adfaf0bb0f306ba89bf7b4c1e", "oldHashes": [ "7177db006a251744584837919a7d4d4a" ] }, "names": [ { "first": "Kyle", "last": "Anderson", "full": "Kyle Anderson" }, { "first": "Rhonda", "middle": "K", "last": "Anderson", "full": "Rhonda K Anderson" } ], "ownerOccupied": true, "ownerStatusTypeCode": "B", "ownerStatusType": "Individual", "ownershipRightsCode": "AT", "ownershipRights": "Joint Tenants" }, "propertyOwnerProfile": { "averageYearBuilt": 2001, "propertiesCount": 1, "propertiesTotalEquity": 449821, "propertiesTotalEstimatedValue": 449821 }, "quickLists": { "absenteeOwner": false, "absenteeOwnerInState": false, "absenteeOwnerOutOfState": false, "activeListing": false, "activeAuction": false, "cashBuyer": false, "corporateOwned": false, "expiredListing": false, "freeAndClear": true, "highEquity": true, "inherited": false, "listedBelowMarketPrice": false, "lowEquity": false, "mailingAddressVacant": false, "onMarket": false, "outOfStateOwner": false, "ownerOccupied": true, "pendingListing": false, "preforeclosure": false, "recentlySold": false, "samePropertyAndMailingAddress": true, "taxDefault": false, "tiredLandlord": false, "unknownEquity": false, "vacant": false, "hasHoa": true, "hasHoaFees": true, "canceledListing": false, "noticeOfSale": false, "noticeOfDefault": false, "noticeOfLisPendens": false }, "sale": { "lastTransfer": { "documentNumber": "2013-0056003", "documentType": "Intra-Family Transfer", "priceCodeDescription": "Transfer Tax on document indicated as EXEMPT.", "priceCode": "Z", "recordingDate": "2013-01-18T00:00:00.000Z", "saleDate": "2012-11-13T00:00:00.000Z" }, "lastSale": { "saleBuyers": [], "saleSellers": [], "salePriceIsEstimated": false }, "flipLength": 0, "flipLengthCategory": 0, "flipProfit": 0, "priorTransfer": { "documentNumber": "2005-0080877", "documentType": "Intra-Family Transfer", "priceCodeDescription": "Non-arms length transaction.", "priceCode": "N", "salePriceIsEstimated": false }, "priorSale": { "recordingDate": "2005-01-20T00:00:00.000Z", "saleBuyers": [], "saleSellers": [], "salePriceIsEstimated": false } }, "tax": { "taxAmount": 19, "taxYear": 2023, "taxDelinquentYear": 2022, "taxRateCodeArea": "971300" }, "valuation": { "estimatedValue": 449821, "priceRangeMin": 395842, "priceRangeMax": 503799, "standardDeviation": 12, "confidenceScore": 88, "asOfDate": "2024-02-28T00:00:00.000Z", "equityCurrentEstimatedBalance": 449821, "ltv": 0, "equityPercent": 100 }, "meta": { "propertyDateModified": "2024-04-11T09:54:59.574Z" } } ], "meta": { "apiVersion": "6.0.0", "performance": { "totalRequestTime": 167, "startTime": "2024-04-16T18:07:52.824Z", "endTime": "2024-04-16T18:07:52.991Z" }, "results": { "resultCount": 1, "resultsFound": 449551, "mlsProviders": [] }, "requestId": "EBilj51hcf9RPC8" } } }';
        Map<String, String> responseHeaders = new Map<String, String>{
            'Content-Type' => 'application/json'
        };
        return new SingleRequestMock(statusCode, status, body, responseHeaders);
    }
    
    private static SingleRequestMock setupErrorMock() {
        Integer statusCode = 400;
        String status = 'Bad Request';
        String body = '{"success": false, "error": "Invalid input"}';
        Map<String, String> responseHeaders = new Map<String, String>{
            'Content-Type' => 'application/json'
        };
        return new SingleRequestMock(statusCode, status, body, responseHeaders);
    }
    
    @IsTest
    static void testAddressVerificationAPI() {
        Test.setMock(HttpCalloutMock.class, setupSuccessMock());
        String reqBody = '{ "requests": [ { "street": "2800 N 24th St", "city": "Phoenix", "state": "AZ", "zip": "85008", "requestId": "" }]}';
        
        Test.startTest();
        String response = BatchLeadIntegration.addressVerificationAPI(reqBody);
        Test.stopTest();
        
        System.assert(response.contains('"success": true'), 'Response should indicate success');

        Test.setMock(HttpCalloutMock.class, setupErrorMock());
        response = BatchLeadIntegration.addressVerificationAPI('{"invalid": "input"}');
        System.assert(response.contains('"success": false'), 'Response should indicate failure');
    }
    
    @IsTest
    static void testAddressAutocompleteAPI() {
        Test.setMock(HttpCalloutMock.class, setupSuccessMock());
        String reqBody = '{ "searchCriteria": { "query": "486 E 28th" }, "options": { "skip": 0, "take": 5 } }';
        
        Test.startTest();
        String response = BatchLeadIntegration.addressAutocompleteAPI(reqBody);
        Test.stopTest();
        
        System.assert(response.contains('"success": true'), 'Response should indicate success');

        Test.setMock(HttpCalloutMock.class, setupErrorMock());
        response = BatchLeadIntegration.addressAutocompleteAPI('{"invalid": "input"}');
        System.assert(response.contains('"success": false'), 'Response should indicate failure');
    }
    
    @IsTest
    static void testPropertyLookupAPI() {
        Test.setMock(HttpCalloutMock.class, setupSuccessMock());
        String reqBody = '{ "requests": [ { "address": { "street": "101 Portsmouth Cir", "city": "Victoria", "state": "TX", "zip": "77904-2501" } } ] }';
        
        Test.startTest();
        String response = BatchLeadIntegration.propertyLookupAPI(reqBody);
       	Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
        System.debug('responseBody::'+responseMap);
        Test.stopTest();
        
        System.assert(response.contains('"success": true'), 'Response should indicate success');

        Test.setMock(HttpCalloutMock.class, setupErrorMock());
        response = BatchLeadIntegration.propertyLookupAPI('{"invalid": "input"}');
        System.assert(response.contains('"success": false'), 'Response should indicate failure');
    }
    
    @IsTest
    static void testPropertySearchAPI() {
        Test.setMock(HttpCalloutMock.class, setupSuccessMock());
        String reqBody = '{ "searchCriteria": { "query": "Phoenix, AZ", "compAddress": { "street": "41028 N Congressional Dr", "city": "phoenix", "state": "AZ", "zip": "85086" } }, "options": { "useYearBuilt": true, "skip": 0, "take": 10 } }';
        
        Test.startTest();
        String response = BatchLeadIntegration.propertySearchAPI(reqBody);
        Test.stopTest();
        
        System.assert(response.contains('"success": true'), 'Response should indicate success');

        Test.setMock(HttpCalloutMock.class, setupErrorMock());
        response = BatchLeadIntegration.propertySearchAPI('{"invalid": "input"}');
        System.assert(response.contains('"success": false'), 'Response should indicate failure');
    }
    
    @IsTest
    static void testPropertySkipTraceAPI() {
        Test.setMock(HttpCalloutMock.class, setupSuccessMock());
        String reqBody = '{ "requests": [ { "propertyAddress": { "city": "Franklin Square", "street": "1011 Rosegold St", "state": "NY", "zip": "11010-2507" } }, { "propertyAddress": { "street": "25866 W Globe Ave", "city": "Buckeye", "state": "AZ", "zip": "85326" } } ], "options": { "skipTraceAlgorithm": "legacy" } }';
        
        Test.startTest();
        String response = BatchLeadIntegration.propertySkipTraceAPI(reqBody);
        Test.stopTest();
        
        System.assert(response.contains('"success": true'), 'Response should indicate success');

        Test.setMock(HttpCalloutMock.class, setupErrorMock());
        response = BatchLeadIntegration.propertySkipTraceAPI('{"invalid": "input"}');
        System.assert(response.contains('"success": false'), 'Response should indicate failure');
    }
    
    @IsTest
    static void testPropertyOwnerProfile() {
        Test.setMock(HttpCalloutMock.class, setupSuccessMock());
        String reqBody = '{ "searchCriteria": { "mailingAddress": { "street": { "equals": "101 Portsmouth Cir" }, "city": { "equals": "Glen Mills" }, "state": { "equals": "PA" } } }, "options": { "skip": 0, "take": 2 } }';
        
        Test.startTest();
        String response = BatchLeadIntegration.propertyOwnerProfile(reqBody);
        Test.stopTest();
        
        System.assert(response.contains('"success": true'), 'Response should indicate success');

        Test.setMock(HttpCalloutMock.class, setupErrorMock());
        response = BatchLeadIntegration.propertyOwnerProfile('{"invalid": "input"}');
        System.assert(response.contains('"success": false'), 'Response should indicate failure');
    }
    
    @IsTest
    static void testPhoneValidation() {
        Test.setMock(HttpCalloutMock.class, setupSuccessMock());
        String reqBody = '{ "requests": [ "2222222222" ] }';
        
        Test.startTest();
        String response = BatchLeadIntegration.phoneValidation(reqBody);
        Test.stopTest();
        
        System.assert(response.contains('"success": true'), 'Response should indicate success');

        Test.setMock(HttpCalloutMock.class, setupErrorMock());
        response = BatchLeadIntegration.phoneValidation('{"invalid": "input"}');
        System.assert(response.contains('"success": false'), 'Response should indicate failure');
    }
    
    @IsTest
    static void testPhoneDNCStatus() {
        Test.setMock(HttpCalloutMock.class, setupSuccessMock());
        String reqBody = '{ "requests": [ "2222222222" ] }';
        
        Test.startTest();
        String response = BatchLeadIntegration.phoneDNCStatus(reqBody);
        Test.stopTest();
        
        System.assert(response.contains('"success": true'), 'Response should indicate success');

        Test.setMock(HttpCalloutMock.class, setupErrorMock());
        response = BatchLeadIntegration.phoneDNCStatus('{"invalid": "input"}');
        System.assert(response.contains('"success": false'), 'Response should indicate failure');
    }
    
    @IsTest
    static void testPhoneTCPAstatus() {
        Test.setMock(HttpCalloutMock.class, setupSuccessMock());
        String reqBody = '{ "requests": [ "2222222222" ] }';
        
        Test.startTest();
        String response = BatchLeadIntegration.phoneTCPAstatus(reqBody);
        Test.stopTest();
        
        System.assert(response.contains('"success": true'), 'Response should indicate success');

        Test.setMock(HttpCalloutMock.class, setupErrorMock());
        response = BatchLeadIntegration.phoneTCPAstatus('{"invalid": "input"}');
        System.assert(response.contains('"success": false'), 'Response should indicate failure');
    }
    
    @IsTest
    static void testRequestDetails() {
        SingleRequestMock mock = setupSuccessMock();
        Test.setMock(HttpCalloutMock.class, mock);
        String reqBody = '{ "requests": [ "2222222222" ] }';
        
        Test.startTest();
        BatchLeadIntegration.phoneTCPAstatus(reqBody);
        Test.stopTest();
        
        HttpRequest sentRequest = mock.getRequest();
        System.assertEquals('POST', sentRequest.getMethod());
        System.assertEquals('https://api.batchdata.com/api/v1/phone/tcpa', sentRequest.getEndpoint());
        System.assertEquals(reqBody, sentRequest.getBody());
    }
}