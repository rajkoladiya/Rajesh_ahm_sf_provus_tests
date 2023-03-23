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
  public static void saveQuote(Id recordId, Date startDate, Date endDate){
      Quote__c quote = new Quote__c(Id = recordId);
      quote.Start_Date__c = startDate;
      quote.EndDate__c = endDate;
      system.debug(quote);
      update quote;
  }

  public override SObject refreshSo() {
    return null;
  }
}
