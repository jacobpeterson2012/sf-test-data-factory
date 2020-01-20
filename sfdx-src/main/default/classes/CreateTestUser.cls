public class CreateTestUser extends CreateTestSObject {
    public CreateTestUser() {
        super(Schema.User.sObjectType, new Set<String> {'isportalenabled','isclosedoncreate'});
    }
}