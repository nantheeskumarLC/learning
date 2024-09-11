import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import propertyLookupAPI from '@salesforce/apex/BatchLeadIntegration.propertyLookupAPI';
import propertySearchAPI from '@salesforce/apex/BatchLeadIntegration.propertySearchAPI';
import propertySkipTraceAPI from '@salesforce/apex/BatchLeadIntegration.propertySkipTraceAPI';
import propertyOwnerProfileAPI from '@salesforce/apex/BatchLeadIntegration.propertyOwnerProfile';
import phoneVerifyAPI from '@salesforce/apex/BatchLeadIntegration.phoneValidation';
import phoneDNCStatusAPI from '@salesforce/apex/BatchLeadIntegration.phoneDNCStatus';
import phoneTCPAStatusAPI from '@salesforce/apex/BatchLeadIntegration.phoneTCPAstatus';
import propertyDetailsSave from '@salesforce/apex/PropertyController.savePropertyDetails'; 
// import propertyOwnerDetails from '@salesforce/apex/PropertyController.savePropertyOwnerDetails';
export default class PropertyValidation extends LightningElement {

    @track propertyLookup = { "requests": [{ "address": { "street": "", "city": "", "state": "", "zip": "" } }] };
    @track propertySearch = { "searchCriteria": { "query": "", "compAddress": { "street": "", "city": "", "state": "", "zip": "" } }, "options": { "useYearBuilt": true, "skip": 0, "take": 10 } };
    @track propertySkipTrace = { "requests": [{ "propertyAddress": { "city": "", "street": "", "state": "", "zip": "" } }], "options": { "skipTraceAlgorithm": "legacy" } };
    @track propertyOwnerProfile = { "searchCriteria": { "mailingAddress": { "street": { "equals": "" }, "city": { "equals": "" }, "state": { "equals": "" } } }, "options": { "skip": 0, "take": 2 } };
    @track phoneVerification = { "requests": [] };
    @track propertyLookupResponse = {};
    @track propertyLookupMortgageList;
    @track propertyLookupDeedHistoryList;
    @track deedHistoryDisplayRecord = [];
    @track mortgageHistoryDisplayRecord = [];
    @track propertySearchResponse = {};
    @track propertySkipTraceResponse = {};
    @track propertySkipTraceMobile = [];
    @track propertySkipTraceLandLine = [];
    @track propertyOwnerProfileResponse = {};
    @track phoneVerificationResponse = {};
    @track phoneDNCResponse = {};
    @track phoneTCPAStatusResponse = {};
    @api addressValidationWrapper = [];
    //isDeedHistory = true;
    //isMortgageHistory = false;
    showAllDeedHistory = false;
    showAllMortageHistory = false;
    viewAll = false;
    @track nodncPhone = [];
    @track phoneTCPAstatus = [];
    @api dynamicClass;
    isPropertyViewed = false;
    isModalOpen = false;
    isPropertySelected = true;
    @track isLoading = false; 

    connectedCallback() {
        this.mapAddressValues();
        this.processAddressValidationResult();
    }

    addPhoneNumberToVerification(phoneNumber) {
        this.phoneVerification.requests.push(phoneNumber);
    }

    mapAddressValues() {
        this.propertyLookup.requests = [];
        this.propertySearch.searchCriteria.compAddress = {};
        this.propertySkipTrace.requests = [];
        this.propertyOwnerProfile.searchCriteria.mailingAddress;

        this.addressValidationWrapper.requests.forEach((address, index) => {
            const { street, city, state, zip } = address;
            // Mapping values to propertyLookup
            this.propertyLookup.requests[index] = {
                address: { street, city, state, zip }
            };
            // Mapping values to propertySearch
            if (index === 0) {
                this.propertySearch.searchCriteria.compAddress = { street, city, state, zip };
            }
            if (city && state) {
                if (this.propertySearch.searchCriteria.query) {
                    this.propertySearch.searchCriteria.query += `, ${city}, ${state}`;
                } else {
                    this.propertySearch.searchCriteria.query = `${city}, ${state}`;
                }
            }
            // Mapping values to propertySkipTrace
            this.propertySkipTrace.requests[index] = {
                propertyAddress: { street, city, state, zip }
            };

            // Mapping values to propertyOwnerProfile
            this.propertyOwnerProfile.searchCriteria.mailingAddress = {
                street: { equals: street },
                city: { equals: city },
                state: { equals: state }
            };
        });
    }

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }


    @api async processAddressValidationResult() {
        this.isLoading = true;
        try {
            // Property Lookup API
            const propertyLookupResult = await propertyLookupAPI({ reqBody: JSON.stringify(this.propertyLookup) });
            this.isValidationBox = false;
            this.propertyLookupResponse = JSON.parse(propertyLookupResult);
            this.propertyLookupResponse.results.properties.forEach(r => {
                this.propertyLookupMortgageList = r.mortgageHistory;
                this.propertyLookupDeedHistoryList = r.deedHistory;

                this.propertyLookupMortgageList.forEach(mortgage => {
                    mortgage.saleDate = this.formatDate(mortgage.saleDate);
                    mortgage.dueDate = this.formatDate(mortgage.dueDate);
                    mortgage.recordingDate = this.formatDate(mortgage.recordingDate);
                });
                this.propertyLookupDeedHistoryList.forEach(deed => {
                    deed.saleDate = this.formatDate(deed.saleDate);
                    deed.recordingDate = this.formatDate(deed.recordingDate);
                });
                this.deedHistoryDisplayRecord = this.propertyLookupDeedHistoryList.slice(0, 3);
                this.mortgageHistoryDisplayRecord = this.propertyLookupMortgageList.slice(0, 3);
                this.dynamicClass = this.dynamicClass === "slds-size_1-of-1 " ? "slds-col slds-size_8-of-12 " : "slds-size_1-of-1 ";
            });

            // Property Search API
            const propertySearchResult = await propertySearchAPI({ reqBody: JSON.stringify(this.propertySearch) });
            this.propertySearchResponse = JSON.parse(propertySearchResult);

            // Property Owner Profile API
            const propertyOwnerProfileResult = await propertyOwnerProfileAPI({ reqBody: JSON.stringify(this.propertyOwnerProfile) });
            this.propertyOwnerProfileResponse = JSON.parse(propertyOwnerProfileResult);

            // Property Skip Trace API
            const propertySkipTraceResult = await propertySkipTraceAPI({ reqBody: JSON.stringify(this.propertySkipTrace) });
            this.propertySkipTraceResponse = JSON.parse(propertySkipTraceResult);
            this.propertySkipTraceResponse.results.persons.forEach(r => {
                r.phoneNumbers.forEach(phone => {
                    if (phone.type === 'Mobile' && phone.reachable && phone.score > 90) {
                        this.propertySkipTraceMobile.push(phone);
                        this.addPhoneNumberToVerification(phone.number);
                    } else if (phone.type === 'Land Line' && phone.reachable && phone.score > 90) {
                        this.propertySkipTraceLandLine.push(phone);
                    }
                });
            });

            // Phone Verify API
            const phoneVerifyResult = await phoneVerifyAPI({ reqBody: JSON.stringify(this.phoneVerification) });
            this.phoneVerificationResponse = JSON.parse(phoneVerifyResult);
            if (this.phoneVerificationResponse.status.code === 200) {
                this.showToast('Success', 'Phone Number is Verified', 'success');
            }

            // Phone DNC Status API
            const phoneDNCStatusResult = await phoneDNCStatusAPI({ reqBody: JSON.stringify(this.phoneVerification) });
            this.phoneDNCResponse = JSON.parse(phoneDNCStatusResult);
            this.phoneDNCResponse.results.phoneNumbers.forEach(r => {
                if (r.dnc === true) {
                    this.nodncPhone = r;
                }
            });

            // Phone TCPA Status API
            const phoneTCPAStatusResult = await phoneTCPAStatusAPI({ reqBody: JSON.stringify(this.phoneVerification) });
            this.phoneTCPAStatusResponse = JSON.parse(phoneTCPAStatusResult);
            this.phoneTCPAStatusResponse.results.phoneNumbers.forEach(phone => {
                if (phone.tcpa === true) {
                    this.phoneTCPAstatus = phone;
                }
            });
        } catch (error) {
            if (error && error.body && error.body.message) {
                errorMessage = error.body.message;
            }
            this.showToast('Error', errorMessage, 'error');
        } finally {
            this.isLoading = false;
        }
    }

    formatDate(dateString) {
        if (!dateString) return '';
        const date = new Date(dateString);
        return date.toISOString().split('T')[0];
    }

    handleDeedHistory() {
        this.showAllDeedHistory = true;
    }

    handleMortgageHistory(){
        this.showAllMortageHistory = true;
    }

    cancelModalClick() {
        this.showAllDeedHistory = false;
        this.showAllMortageHistory = false;
    }

    handleSave() {
    const propertyDetailsPromise = propertyDetailsSave({ responseBody: JSON.stringify(this.propertyLookupResponse) });
    propertyDetailsPromise
        .then(results => {
            this.showToast('Success', 'Property Details and Owner Details Saved', 'success');
        })
        .catch(error => {
            if (error && error.body && error.body.message) {
                errorMessage = error.body.message;
            }
            this.showToast('Error', errorMessage, 'error');
        });
}

    

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}