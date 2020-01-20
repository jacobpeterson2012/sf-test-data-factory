public class CreateTestOrder extends CreateTestSObject {
    public CreateTestOrder() {
        super(Schema.Order.sObjectType, new Set<String> {'statuscode'});
        this.addOverrideValue('status', 'Draft');
    }
}