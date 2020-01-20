public class CreateTestAccount extends CreateTestSObject {
    public CreateTestAccount() {
        super(Schema.Account.sObjectType, new Set<String> {'iscustomerportal'});
    }
}