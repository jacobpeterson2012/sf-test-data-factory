public class CreateTestPriceBookEntry extends CreateTestSObject{
    public CreateTestPriceBookEntry() {                
        super(Schema.PriceBookEntry.sObjectType, new Set<String>{}); 
        this.addOverrideValue('isactive', true); 
    }     
}