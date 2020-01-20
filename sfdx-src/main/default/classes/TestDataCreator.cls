public interface TestDataCreator {
    List<sObject> createMultipleObjects(Integer numberToCreate);
    List<sObject> createMulitpleObjects(Integer numberToCreate);
    List<sObject> createMultipleObjectsforParents(Integer numberToCreate, List<sObject> parentList, String field);
    sObject createObject();
    sObject createObject(Integer incrementor);
    CreateTestSObject addOverrideValue(String field, Object value);
    CreateTestSObject addValidationRequiredField(String field);
}