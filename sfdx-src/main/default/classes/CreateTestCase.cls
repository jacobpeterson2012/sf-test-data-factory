public class CreateTestCase extends CreateTestSObject {
    public CreateTestCase() {
        super(Schema.Case.sObjectType, new Set<String> {'isclosedoncreate'});
        addValueOverrides();
        addValidationRuleOverrides();
    }

    private void addValueOverrides(){
        this.addOverrideValue('Type','Technical Troubleshooting');
        this.addOverrideValue('SubType__c','Option 1');
    }

    private void addValidationRuleOverrides() {
        this.addValidationRequiredField('origin');
        this.addValidationRequiredField('status');
    }
}
