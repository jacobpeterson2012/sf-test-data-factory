public interface TestDataCreator {
    List<SObject> createMultipleObjects(Integer numberToCreate);
    List<SObject> createMultipleObjectsforParents(Integer numberToCreate, List<sObject> parentList, String field);
    SObject createObject();
    SObject createObject(Integer incrementor);
    CreateTestSObject addOverrideValue(String field, Object value);
    CreateTestSObject addValidationRequiredField(String field);
    CreateTestSObject addRelation(SObject relation, String relationIdFieldName, String relationFieldName);
    CreateTestSObject withTestIds();
}