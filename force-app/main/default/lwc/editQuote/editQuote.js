/*
 * Provus Services Quoting
 * Copyright (c) 2023 Provus Inc. All rights reserved.
 */

import { LightningElement, api , wire} from "lwc";

import getRecord from '@salesforce/apex/QuoteDto.getRecord';
import saveQuote from '@salesforce/apex/QuoteDto.saveQuote';
import {refreshApex} from '@salesforce/apex';

import {ShowToastEvent} from "lightning/platformShowToastEvent";

export default class EditQuote extends LightningElement {
  @api recordId; quoteData; isLoaded = false;

  get startDate(){
    return this._startDate? this._startDate : this.quoteData.startDate;
  }

  get endDate(){
    return this._endDate? this._endDate : this.quoteData._endDate;
  }

  changeStartHandle(event){
    this.quoteData.startDate = event.target.value;
  }

  changeEndHandle(event){
    this.quoteData.endDate = event.target.value;
  }


  saveDetails(){
    saveQuote({
      quote : this.quoteData
    })
    .then(() =>{
      const toastEvent = new ShowToastEvent({
        title : 'Success',
        message : 'Quote updated Successfully!',
        variant : 'success'
      });

      refreshApex(this.wiredGetRecord);
    })
    .catch((err) =>{
      console.log("#error..");
    });
  }
  
  renderedCallback() {}

  @wire (getRecord , { recordId : "$recordId"})
  wiredGetRecord({error, data}){
    if(data){ 
      this.quoteData = JSON.parse(JSON.stringify(data));
      this.isLoaded = true;
    }else if(error){
      console.log('##Error ');
    }
  }

  

}
