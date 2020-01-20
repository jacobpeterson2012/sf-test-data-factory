public class CreateTestContact extends CreateTestSObject {
    public CreateTestContact() {
        super(Schema.Contact.sObjectType, new Set<String>());
        addValidationRuleOverrides();
    }

    private void addValidationRuleOverrides() {
        this.addValidationRequiredField('accountid');
        this.addValidationRequiredField('birthdate');
        this.addValidationRequiredField('email');
        this.addValidationRequiredField('firstname');
    }
}