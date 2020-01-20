@IsTest(isParallel = true)
public class TestDataDefaultFieldValueTest {

    @IsTest
    static void testWithNullIncrement() {
        TestDataDefaultFieldValue t = new TestDataDefaultFieldValue(Account.Description.getDescribe());
        Object val = t.getDefaultValue();
        system.assert(val != null, 'Exepcted value for test field');
    }
    @IsTest
    static void testWithIncrement() {
        TestDataDefaultFieldValue t = new TestDataDefaultFieldValue(Account.Name.getDescribe(), 100);
        String val = (String) t.getDefaultValue();
        system.assertNotEquals(val, null, 'Exepcted value for test field');
        system.assert(val.contains('100'), 'Exepcted incrementor value');
    }
    
    @IsTest 
    static void testValuesGenerated(){
        TestDataDefaultFieldValue t = new TestDataDefaultFieldValue(Account.Description.getDescribe());
        t.fieldType = Schema.DisplayType.BASE64;
        
        List<Schema.DisplayType> types = new List<Schema.DisplayType>(); 
        types.add(Schema.DisplayType.Base64);
        types.add(Schema.DisplayType.Boolean);
        types.add(Schema.DisplayType.Currency);
        types.add(Schema.DisplayType.Date);
        types.add(Schema.DisplayType.Datetime);
        types.add(Schema.DisplayType.Email);
        types.add(Schema.DisplayType.Location);
        types.add(Schema.DisplayType.Integer);
        types.add(Schema.DisplayType.Double);
        types.add(Schema.DisplayType.Percent);
        types.add(Schema.DisplayType.Phone);
        types.add(Schema.DisplayType.String);
        types.add(Schema.DisplayType.TextArea);
        types.add(Schema.DisplayType.Time);
        types.add(Schema.DisplayType.URL);
        
        for (Schema.DisplayType dt : types){
            t.fieldType = dt;
            Object val = t.getDefaultValue();
            system.assertNotEquals(val, null, 'Expected value for :' + dt);
        }
        
        system.assertNotEquals(t.getBase64DefaultValue(), null, 'Expected value for getBase64DefaultValue');
        system.assertNotEquals(t.getCheckboxDefaultValue(), null, 'Expected value for getCheckboxDefaultValue');
        system.assertNotEquals(t.getCurrencyDefaultValue(), null, 'Expected value for getCurrencyDefaultValue');
        system.assertNotEquals(t.getDateDefaultValue(), null, 'Expected value for getDateDefaultValue');
        system.assertNotEquals(t.getDateTimeDefaultValue(), null, 'Expected value for getDateTimeDefaultValue');
        system.assertNotEquals(t.getEmailDefaultValue(), null, 'Expected value for getEmailDefaultValue');
        system.assertNotEquals(t.getGeolocationDefaultValue(), null, 'Expected value for getGeolocationDefaultValue');
        system.assertNotEquals(t.getNumberDefaultValue(), null, 'Expected value for getNumberDefaultValue');
        system.assertNotEquals(t.getPercentDefaultValue(), null, 'Expected value for getPercentDefaultValue');
        system.assertNotEquals(t.getPhoneDefaultValue(), null, 'Expected value for getPhoneDefaultValue');
        system.assertNotEquals(t.getTextDefaultValue(), null, 'Expected value for getTextDefaultValue');
        system.assertNotEquals(t.getTextAreaDefaultValue(), null, 'Expected value for getTextAreaDefaultValue');
        system.assertNotEquals(t.getTimeDefaultValue(), null, 'Expected value for getTimeDefaultValue');    
        system.assertNotEquals(t.getURLDefaultValue(), null, 'Expected value for getURLDefaultValue'); 
        
    }
    
    @IsTest
    static void testPickListValue() {
        TestDataDefaultFieldValue t = new TestDataDefaultFieldValue(Account.Rating.getDescribe());
        Object val = t.getDefaultValue();
        system.assert(val != null, 'Exepcted value for test field');
    }
    
    @IsTest
    static void testMultiPickListValue() {
        TestDataDefaultFieldValue t = new TestDataDefaultFieldValue(Account.Rating.getDescribe());
        Object val = t.getDefaultValue();
        system.assert(val != null, 'Exepcted value for picklist field');
        val = t.getMultiPicklistDefaultValue();
        system.assert(val != null, 'Exepcted value for multipicklist field');
    }
    
}