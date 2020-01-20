public class TestDataFactory {
    static public TestDataCreator getAccountCreator() {
        return new CreateTestAccount();
    }
    static public TestDataCreator getContactCreator() {
        return new CreateTestContact();
    }
    static public TestDataCreator getOrderCreator() {
        return new CreateTestOrder();
    }
    static public TestDataCreator getOrderItemCreator() {
        return new CreateTestOrderItem();
    }
    static public TestDataCreator getProductCreator() {
        return new CreateTestProduct();
    }
    static public TestDataCreator getPriceBookEntryCreator() {
        return new CreateTestPriceBookEntry();
    }
    static public TestDataCreator getCaseCreator() {
        return new CreateTestCase();
    }
   static public TestDataCreator getUserCreator() {
        return new CreateTestUser();
    }

    static public TestDataCreator getsObjectCreator(Schema.SObjectType sObjectType) {
        if (sObjectType == Schema.Order.sObjectType) {
             return new CreateTestOrder();
        }
        if (sObjectType == Schema.OrderItem.sObjectType) {
           return new CreateTestOrderItem();
        }
        if (sObjectType == Schema.Account.sObjectType) {
            return new CreateTestAccount();
        }
        if (sObjectType == Schema.Contact.sObjectType) {
            return new CreateTestContact();
        }
        if (sObjectType == Schema.Product2.sObjectType) {
            return new CreateTestProduct();
        }
        if (sObjectType == Schema.PriceBookEntry.sObjectType) {
            return new CreateTestPriceBookEntry();
        }
        if (sObjectType == Schema.Case.sObjectType) {
            return new CreateTestCase();
        }
        if (sObjectType == Schema.User.sObjectType) {
            return new CreateTestUser();
        }
        return new CreateTestSObject(sObjectType, new Set<String>());
    }
}