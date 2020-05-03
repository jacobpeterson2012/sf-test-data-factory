public virtual class CreateTestSObject implements TestDataCreator {
    protected Set<String> ignoreFields = new Set<String> {'ownerid'};
    private Map<String, Object> fieldValueOverrides = new Map<String, Object>();
    private Set<String> validationRequiredFields = new Set<String>();
    private Map<String, CreateTestSObject.ObjectField> inScopeFields = new Map<String, CreateTestSObject.ObjectField>();

    private SObject relation;
    private String relationIdFieldName;
    private String relationFieldName;
    private Boolean generateTestIds = false;

    protected Schema.SObjectType SObjectType;
    protected Integer incrementor;

    private CreateTestSObject() {return;}

    public CreateTestSObject(Schema.SObjectType SObjectType, Set<String> ignoreFields) {
        this.SObjectType = SObjectType;
        if (ignoreFields != null) {
            this.ignoreFields.addAll(ignoreFields);
        }
        setInScopeFields();
    }

    public List<SObject> createMultipleObjectsforParents(Integer numberToCreate, List<SObject> parentList, String field) {
        List<SObject> result = new List<SObject>();
        for (SObject obj : parentList) {
            this.addOverrideValue(field, obj.Id);
            result.addall(createMultipleObjects(numberToCreate));
        }

        return result;
    }

    public List<SObject> createMultipleObjects(Integer numberToCreate) {
        List<SObject> result = new List<SObject>();
        for (Integer i = 0; i < numberToCreate; i++) {
            result.add(createobject(i + 1));
        }
        return result;
    }

    public SObject createObject() {
        return createObject((Integer) null);
    }

    public SObject createObject(Integer incrementor) {
        this.incrementor = incrementor;
        SObject newObject = SObjectType.newSObject();

        if (generateTestIds) {
            newObject.put('Id', TestId.generate(this.SObjectType));
        }
        for (CreateTestSObject.ObjectField fld  : this.inScopeFields.values()) {
            if (valueRequired(fld)) {
                newObject.put(fld.fieldName(), getValueRequiredForField(fld));
            }
        }
        newObject = addRelationExecute(newObject);
        return newObject;
    }


    private Boolean valueRequired(CreateTestSObject.ObjectField fld) {
        return (fld.isRequired()
               || this.validationRequiredFields.contains(fld.fieldName().toLowerCase())
               || this.fieldValueOverrides.containsKey(fld.fieldName().toLowerCase()));
    }

    private Object getValueRequiredForField(CreateTestSObject.ObjectField fld) {
        Object val;
        if (this.fieldValueOverrides.containsKey(fld.fieldName().toLowerCase())) {
            val = this.fieldValueOverrides.get(fld.fieldName().toLowerCase());
        } else {
            val = new TestDataDefaultFieldValue(fld.fieldDesc, this.incrementor).getDefaultValue();
        }
        return val;
    }

    private SObject addRelationExecute(SObject parent) {
        if (this.relation == null
            || String.isEmpty(this.relationIdFieldName)
            || String.isEmpty(this.relationFieldName)) {

                return parent;
        }
        String parentJson = JSON.serialize(parent);
        String parentPartStart = parentJson.left(parentJson.lastIndexOf('}'));

        List<String> resultBuilder = new List<String>();
        resultBuilder.add(parentPartStart);
        appendRelationIdField(resultBuilder);
        appendRelationRelatedObjectField(resultBuilder);
        resultBuilder.add('}');

        String result = String.join(resultBuilder, '');
        return (SObject) JSON.deserialize(result, SObject.class);
    }

    private void appendRelationRelatedObjectField(List<String> resultBuilder) {
        resultBuilder.add(',');
        resultBuilder.add('"' + this.relationIdFieldName + '"');
        resultBuilder.add(':');
        resultBuilder.add('"' + this.relation.id + '"');
    }

    private void appendRelationIdField(List<String> resultBuilder ) {
        String relationJson = JSON.serialize(relation);
        resultBuilder.add(',');
        resultBuilder.add('"' + this.relationFieldName + '"');
        resultBuilder.add(':');
        resultBuilder.add(relationJson);
    }

    private void setInScopeFields() {
        Map<String,Schema.SObjectField> allFields = this.SObjectType.getDescribe().fields.getMap();

        for (String fieldName : allFields.keySet()) {
            if (!this.ignoreFields.contains(fieldName)) {
                Schema.SObjectField field = allFields.get(fieldName);
                ObjectField fieldInstance = new ObjectField(field.getDescribe());
                this.inScopeFields.put(fieldName,fieldInstance);
            }
        }
    }

    private class ObjectField {
        public Schema.DescribeFieldResult fieldDesc;

        public String fieldName() {
            return fieldDesc.getName();
        }

        public ObjectField(Schema.DescribeFieldResult fieldDesc) {
            this.fieldDesc = fieldDesc;
        }

        public Boolean isRequired() {
            return (!fieldDesc.isNillable() && fieldDesc.isUpdateable());
        }
    }

    private SObject createObject(Map<String, object> overrideValues) {
        return createObject(overrideValues,null);
    }

    private SObject createObject(Map<String, object> overrideValues, Integer incrementor) {
        this.fieldValueOverrides.putAll(overrideValues);
        return createObject(incrementor);
    }

    public CreateTestSObject addOverrideValue(String field, Object value) {
        this.fieldValueOverrides.put(field.toLowerCase(), value);
        return this;
    }

    public CreateTestSObject addValidationRequiredField(String field) {
        this.validationRequiredFields.add(field.toLowerCase());
        return this;
    }

    public CreateTestSObject addRelation(SObject relation, String relationIdFieldName, String relationFieldName) {
        this.relation = relation;
        this.relationIdFieldName = relationIdFieldName;
        this.relationFieldName = relationFieldName;
        return this;
    }

    public CreateTestSObject withTestIds() {
        generateTestIds = true;
        return this;
    }
}