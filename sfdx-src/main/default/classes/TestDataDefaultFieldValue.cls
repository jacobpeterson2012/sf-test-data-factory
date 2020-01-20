public class TestDataDefaultFieldValue {
    private Schema.DescribeFieldResult fieldDesc;
    @TestVisible
    private Schema.DisplayType fieldType;
    private final string DEFAULT_VALUE;
	private Integer incrementor;
    
    public TestDataDefaultFieldValue(Schema.DescribeFieldResult fieldDesc) {
        this(fieldDesc, null);
    }
    
    public TestDataDefaultFieldValue(Schema.DescribeFieldResult fieldDesc, Integer incrementor) {
        this.fieldDesc = fieldDesc;
        this.fieldType = fieldDesc.getType();
        this.incrementor = incrementor;
        DEFAULT_VALUE = 'Test' + (incrementor == null ? '' : String.valueOf(incrementor));
    }
    
    public Object getDefaultValue() {
        if (this.fieldDesc == null) {
            return null;
        }
        switch on this.fieldType {
            when Base64 {
                return getBase64DefaultValue();
            }
            when Boolean {
                return getCheckboxDefaultValue();
            }
            when Currency {
                return getCurrencyDefaultValue();
            }
            when Date {
                return getDateDefaultValue();
            }
            when Datetime {
                return getDateTimeDefaultValue();
            }
            when Email {
                return getEmailDefaultValue();
            }
            when Location {
                return getGeolocationDefaultValue();
            }
            when Integer, Double {
                return getNumberDefaultValue();
            }
            when Percent {
                return getPercentDefaultValue();
            }
            when Phone {
                return getPhoneDefaultValue();
            }
            when Picklist {
                return getPicklistDefaultValue();
            }
            when MultiPicklist {
                return getMultiPicklistDefaultValue();
            }
            when String {
                return getTextDefaultValue();
            }
            when TextArea {
                return getTextAreaDefaultValue();
            }
            when Time {
                return getTimeDefaultValue();
            }
            when URL {
                return getURLDefaultValue();
            }
        }
        return null;
    }
    @Testvisible
    private Blob getBase64DefaultValue() {
        return Blob.valueOf(DEFAULT_VALUE);
    }   
    @Testvisible
    private Boolean getCheckboxDefaultValue(){
        return false;
    }
    @Testvisible
    private Decimal getCurrencyDefaultValue(){
        return 1;
    }
    @Testvisible
    private Date getDateDefaultValue(){
        return Date.today();
    }
    @Testvisible
    private Datetime getDateTimeDefaultValue(){
        return Datetime.now();
    }
    @Testvisible
    private String getEmailDefaultValue(){
        return DEFAULT_VALUE + string.valueof(DateTime.now().getTime()) + '@example' + DEFAULT_VALUE + '.com';
    }
    @Testvisible
    private Location getGeolocationDefaultValue(){
        return Location.newInstance(0,0);
    }      
    @Testvisible
    private Decimal getNumberDefaultValue(){
        return 1 + + (incrementor == null ? 1 : 0);
    }
    @Testvisible
    private Decimal getPercentDefaultValue(){
        return 1 + + (incrementor == null ? 1 : 0);
    }
    @Testvisible
    private String getPhoneDefaultValue(){
        return '01 23 45 67 89';
    }
    @Testvisible
    private String getPicklistDefaultValue(){
        return getSFDefaultPicklistValue(this.fieldDesc.getPicklistValues());        	
    }
    @Testvisible
    private String getMultiPicklistDefaultValue() {
        return getSFDefaultPicklistValue(this.fieldDesc.getPicklistValues());              
    }
    @Testvisible
    private String getTextDefaultValue(){
        return DEFAULT_VALUE;
    }
    @Testvisible
    private String getTextAreaDefaultValue(){
        return DEFAULT_VALUE;
    }
    @Testvisible
    private Time getTimeDefaultValue(){
        return Time.newInstance(12, 0, 0, 0);
    }
    @Testvisible
    private String getURLDefaultValue(){
        return 'http://'  + DEFAULT_VALUE + 'com';
    }
    
    private String getSFDefaultPicklistValue(List<Schema.PicklistEntry> pickVals) {
            
        for (Schema.PicklistEntry pickVal: pickVals) {
            if (pickVal.isDefaultValue()) {
                return pickVal.getValue();
            }    
        }            
        return pickVals.get(0).getValue();
    }
}