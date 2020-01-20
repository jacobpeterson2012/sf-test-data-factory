public virtual class CreateTestSObject implements TestDataCreator {
    protected Set<String> ignoreFields = new Set<String> {'ownerid'};
    private Map<String, Object> fieldValueOverrides = new Map<String, Object>();
    private Set<String> validationRequiredFields = new Set<String>();
    private Map<String, CreateTestSObject.ObjectField> inScopeFields = new Map<String, CreateTestSObject.ObjectField>();
    protected Schema.SObjectType sObjectType;
    protected integer incrementor;
    private CreateTestSObject() {return;}
	
    public CreateTestSObject(Schema.SObjectType sObjectType, Set<String> ignoreFields) {
        this.sObjectType = sObjectType;
        if (ignoreFields != null) {
            this.ignoreFields.addAll(ignoreFields);
        }
        Schema.DescribeSObjectResult r = sObjectType.getDescribe();
        setFieldInScope(r.fields.getMap());
    }

    public List<sObject> createMultipleObjectsforParents(Integer numberToCreate, List<sObject> parentList, String field) {
        List<sObject> result = new List<sObject>();
        for (sObject obj : parentList) {
            this.addOverrideValue(field, obj.Id);
            result.addall(createMultipleObjects(numberToCreate)); 
        }

        return result;
    }

    public List<sObject> createMultipleObjects(Integer numberToCreate) {
        List<sObject> result = new List<sObject>();
        for (Integer i = 0; i < numberToCreate; i++) {
            result.add(createobject(i + 1));
        }
        return result;
    }
    
    public List<sObject> createMulitpleObjects(Integer numberToCreate) {
        List<sObject> result = new List<sObject>();
        for (Integer i = 0; i < numberToCreate; i++) {
            result.add(createobject(i + 1));
        }
        return result;
    }

    public sObject createObject() {
        return createObject((Integer) null);
    }

    public sObject createObject(Integer incrementor) {
        this.incrementor = incrementor;
        sObject newObject = sObjectType.newSObject();
        for (String inScopeFieldName : inScopeFields.keySet()) {
            CreateTestSObject.ObjectField fld = inScopeFields.get(inScopeFieldName.toLowerCase());
            if (inScopeField(fld,inScopeFieldName)) {
                Object val;
                if (fieldValueOverrides.containsKey(inScopeFieldName.toLowerCase())) {
                    val = fieldValueOverrides.get(inScopeFieldName);
                } else {
                    val = new TestDataDefaultFieldValue(fld.fieldDesc,incrementor).getDefaultValue();
                }
                newObject.put(inScopeFieldName, val);
            }
        }
        return newObject;
    }
    private Boolean inScopeField(CreateTestSObject.ObjectField fld, String fieldName) {
        return (fld.isRequired()
               || validationRequiredFields.contains(fieldName.toLowerCase())
               || fieldValueOverrides.containsKey(fieldName.toLowerCase()));
    }
    private sObject createObject(Map<String, object> overrideValues) {
        return createObject(overrideValues,null);
    }

    private sObject createObject(Map<String, object> overrideValues, Integer incrementor) {
        fieldValueOverrides.putAll(overrideValues);
        return createObject(incrementor);
    }

    public CreateTestSObject addOverrideValue(String field, Object value) {
        fieldValueOverrides.put(field.toLowerCase(), value);
        return this;
    }

    public CreateTestSObject addValidationRequiredField(String field) {
        validationRequiredFields.add(field.toLowerCase());
        return this;
    }

    private void setFieldInScope(Map<String,Schema.SObjectField> allFields) {
        for (String fieldName : allFields.keySet()) {
            if (!ignoreFields.contains(fieldName)) {
                Schema.SObjectField field = allFields.get(fieldName);
                ObjectField fieldInstance = new ObjectField(field.getDescribe());
                this.inScopeFields.put(fieldName,fieldInstance);
            }
        }
    }

    class ObjectField {
        public Schema.DescribeFieldResult fieldDesc;
        public ObjectField(Schema.DescribeFieldResult fieldDesc) {
            this.fieldDesc = fieldDesc;
        }

        public Boolean isRequired() {
            return (!fieldDesc.isNillable() && fieldDesc.isUpdateable());
        }
    }
}