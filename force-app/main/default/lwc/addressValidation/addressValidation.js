import { LightningElement,track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import addressVerificationAPI from '@salesforce/apex/BatchLeadIntegration.addressVerificationAPI';
import addressAutocompleteResult from '@salesforce/apex/BatchLeadIntegration.addressAutocompleteAPI';

export default class AddressValidation extends LightningElement {
    
    @track isAutocompleteLoading = false;
    @track isSpinnerResponse = false;
    @track validationApiResponse = {};
    @track autoCompleteAPIResponse = {};
    @track addressValidationWrapper = { "requests": [ { "street": "", "city": "", "state": "", "zip": "", "requestId": "",  "hideRemoveButton":false} ] };
    @track addressAutocompleteAPI = { "searchCriteria": { "query": "" }, "options": { "skip": 0, "take": 5 } };
    isValidationBox = true;
    @track dynamicClass = "slds-col slds-size_8-of-12 ";
    @track iconDirection = 'utility:left';
    propertyValidation = false;
    isChildComponent = false;

    handleValidateLayout() {
       // this.dynamicClass = this.isValidationBox ? 'slds-size_1-of-1' : 'slds-col slds-size_9-of-12'
        this.dynamicClass = this.dynamicClass === "slds-size_1-of-1 " ? "slds-col slds-size_8-of-12 " : "slds-size_1-of-1 ";
        this.isValidationBox = !this.isValidationBox;
        this.iconDirection = this.iconDirection === 'utility:left' ? 'utility:right' : 'utility:left'; 
    }

    handleChangeAddress(event) {
        const index = event.target.dataset.index;
        const name = event.currentTarget.dataset.name;
        const value = event.target.value;
        if (name === "StreetLine1") {
            this.isAutocompleteLoading = true;
            this.addressValidationWrapper.requests[index].street = value;
            this.addressAutocompleteAPI.searchCriteria.query = value;
        } else if (name === "city") {
            this.addressValidationWrapper.requests[index].city = value;
        } else if (name === "state") {
            this.addressValidationWrapper.requests[index].state = value;
        } else if (name === "postal") {
            this.addressValidationWrapper.requests[index].zip = value;
        }
    }

    handleKeyUp(evt) {
        const isEnterKey = evt.keyCode === 13;
        const name = evt.currentTarget.dataset.name;
        if (isEnterKey || name === "StreetLine1") {
            this.callApexController();
        }
    }

    selectSearchResult(event) {
    this.isAutocompleteLoading = false;
    const index = event.currentTarget.dataset.index;
    const selectedAddress = event.currentTarget.dataset.value;
    const parts = selectedAddress.split(',');
    if (parts.length >= 3) {
        this.addressValidationWrapper.requests[index].street = parts[0];
        this.addressValidationWrapper.requests[index].city = parts[1];
        const statePostal = parts[parts.length - 1].split(' ');
        if (statePostal.length >= 2) {
            this.addressValidationWrapper.requests[index].state = statePostal[statePostal.length - 2];
            this.addressValidationWrapper.requests[index].zip = statePostal[statePostal.length - 1];
        }
    }
    }

    callApexController() { 
        addressAutocompleteResult({ reqBody: JSON.stringify(this.addressAutocompleteAPI) })
            .then(result => {
                console.log('Apex Controller Response:', result);
                this.autoCompleteAPIResponse =  JSON.parse(result);
            })
            .catch(error => {
                console.error('Error from Apex Controller:', error);
            });
    }

    handleAddNewAddress() {
        let index = this.addressValidationWrapper.requests.length - 1;
        let id = this.addressValidationWrapper.requests.length > 0 ? this.addressValidationWrapper.requests[index].requestId + 1 : 0;
        if (this.addressValidationWrapper.requests.length > 0){
            this.addressValidationWrapper.requests[index].hideRemoveButton = true;
        }
        this.addressValidationWrapper.requests.push({ 
            street: '',
            city: '',
            state: '',
            zip: '',requestId: id,
            hideRemoveButton: true });
    }

    handleRemove(event){
        const index = event.currentTarget.dataset.index;
        this.addressValidationWrapper.requests.splice(index , 1);
        if (this.addressValidationWrapper.requests.length > 1){
            this.addressValidationWrapper.requests[index].hideRemoveButton = true;
        } else if (this.addressValidationWrapper.requests.length < 2){
            this.addressValidationWrapper.requests[index].hideRemoveButton = false;
        }
    }

    addPhoneNumberToVerification(phoneNumber) {
        this.phoneVerification.requests.push(phoneNumber);
    }
    
   validateAddressOnClick() {
    this.isSpinnerResponse = true;
    // Address Verification API
    addressVerificationAPI({ reqBody: JSON.stringify(this.addressValidationWrapper) })
        .then(result => {
            this.isChildComponent = true;
            this.validationApiResponse = JSON.parse(result);

            if (this.validationApiResponse.status.code === 200) {
                this.showToast('Success', 'Address Verified', 'success');
                this.propertyValidation = true;
                const childComponent = this.template.querySelector('c-property-validation');
                if (childComponent) {
                    childComponent.processAddressValidationResult();
                }
            } else {
                this.showToast('Error', this.validationApiResponse.status.message, 'error');
            }
        })
        .catch(error => {
            this.showToast('Error', 'There was an error verifying the address.', 'error');
        })
        .finally(() => {
            this.isSpinnerResponse = false;
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