public with sharing class QuoteDto extends BaseDto {

  @AuraEnabled 
  public Date endDate {get;set;}
  @AuraEnabled 
  public Date startDate {get;set;}

  @AuraEnabled(cacheable=true)
  public static QuoteDto getRecord(Id recordId){
    try{
          Quote__c quote = [SELECT Id, Name, Start_Date__c , EndDate__c 
                                  FROM Quote__c
                                  WHERE Id =: recordId];
          return new QuoteDto(quote);
    }catch(Exception ex){
      throw new AuraHandledException(ex.getMessage());
    }
  }
  public QuoteDto() {
  }

  public QuoteDto(Quote__c quote) {
    super(quote);
    this.endDate = quote.EndDate__c;
    this.startDate = quote.Start_Date__c;
    this.name = quote.Name;
  }

  @AuraEnabled
  public static void saveQuote(QuoteDto quote){
      Quote__c quo = quote.GetQuote();
      system.debug(quo);
      update quo;
      system.debug(quo);
  }

  public Quote__c GetQuote() {
    Quote__c quote = new Quote__c();
    quote.id = super.id;
    quote.Start_Date__c = this.startDate;
    quote.EndDate__c = this.endDate;
    return quote;
  }

  public override SObject refreshSo() {
    return null;
  }
}
