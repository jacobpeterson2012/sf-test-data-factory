public class CreateTestProduct extends CreateTestSObject { 
    public CreateTestProduct() {
        super(Schema.Product2.sObjectType, new Set<String>());        
        this.addOverrideValue('isactive', true);
        this.addValidationRequiredField('productcode');   
    }
}