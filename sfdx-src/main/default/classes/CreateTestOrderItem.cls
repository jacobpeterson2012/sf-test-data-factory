public class CreateTestOrderItem extends CreateTestSObject {    
  	public CreateTestOrderItem() {
        super(Schema.OrderItem.sObjectType, new Set<String>());        
        this.addValidationRequiredField('unitprice');      
    }
}