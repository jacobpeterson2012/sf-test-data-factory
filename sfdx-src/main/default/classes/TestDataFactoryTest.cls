@IsTest(IsParallel = false)
private class TestDataFactoryTest {
    @IsTest
    private static void testinsert() {
        List<SObject> accounts = [SELECT Id FROM Account];
        List<SObject> contacts = [SELECT Id FROM Contact];
        List<SObject> cases = [SELECT Id FROM Case];
        List<SObject> products = [SELECT Id FROM Product2];
        List<SObject> pbentries = [SELECT Id FROM PriceBookEntry];
        List<SObject> orders = [SELECT Id FROM Order];
        List<SObject> orderitems = [SELECT Id FROM OrderItem];
        List<SObject> tasks = [SELECT Id FROM Task];
        List<SObject> users = [SELECT Id FROM User];
        List<SObject> assets = [SELECT Id from Asset];

        System.assertNotEquals(accounts.size(), 0, 'Expected accounts to be created');
        System.assertNotEquals(contacts.size(), 0, 'Expected contacts to be created');
        System.assertNotEquals(cases.size(), 0, 'Expected cases to be created');
        System.assertNotEquals(products.size(), 0, 'Expected products to be created');
        System.assertNotEquals(pbentries.size(), 0, 'Expected pbentries to be created');
        System.assertNotEquals(orders.size(), 0, 'Expected orders to be created');
        System.assertNotEquals(orderitems.size(), 0, 'Expected orderitems to be created');
        System.assertNotEquals(tasks.size(), 0, 'Expected Task to be created');
    }

    @TestSetup
    private static void testDataSetup() {
        //Create Account
        List<SObject> accounts = TestDataFactory.getAccountCreator().createMultipleObjects(5);
        //Create Account via generic method
        accounts.addAll(TestDataFactory.getSObjectCreator(Schema.Account.SObjectType).createMultipleObjects(1));
        insert accounts;

        //Create Contacts
        List<SObject> contacts = TestDataFactory.getContactCreator()
                .addOverrideValue('accountid', accounts[0].Id)
                .createMultipleObjects(5);
        contacts.addAll(TestDataFactory.getSObjectCreator(Schema.Contact.SObjectType)
                .addOverrideValue('accountid', accounts[0].Id)
                .createMultipleObjects(1));
        insert contacts;

        //Create Case
        List<SObject> caseRecords = TestDataFactory.getCaseCreator()
                .addOverrideValue('accountid', accounts[0].Id)
                .createMultipleObjects(5);
        //Create Case via generic method
        caseRecords.addAll(TestDataFactory.getSObjectCreator(Schema.Case.SObjectType)
                .addOverrideValue('accountid', accounts[0].Id)
                .createMultipleObjects(1));
        insert caseRecords;

        //Create product
        List<SObject> products = TestDataFactory.getProductCreator().createMultipleObjects(2);
        products.addAll(TestDataFactory.getSObjectCreator(Schema.Product2.SObjectType).createMultipleObjects(1));
        insert products;

        //Get Standard Pricebook Id
        Id pricebookId = Test.getStandardPricebookId();
        List<SObject> pbentries = TestDataFactory.getPriceBookEntryCreator()
                .addOverrideValue('pricebook2id', pricebookId)
                .addOverrideValue('product2id', products[0].Id)
                .createMultipleObjects(1);
        pbentries.add(TestDataFactory.getSObjectCreator(Schema.PriceBookEntry.SObjectType)
                .addOverrideValue('pricebook2id', pricebookId)
                .addOverrideValue('product2id', products[1].Id)
                .createObject());
        insert pbentries;

        //Create Order
        List<SObject> orders = TestDataFactory.getOrderCreator()
                .addOverrideValue('accountid', accounts[0].Id)
                .addOverrideValue('pricebook2id', pricebookId)
                .createMultipleObjects(5);
        orders.addAll(TestDataFactory.getSObjectCreator(Schema.Order.SObjectType)
                .addOverrideValue('accountid', accounts[0].Id)
                .addOverrideValue('pricebook2id', pricebookId)
                .createMultipleObjects(1));
        insert orders;

        //Create orderItems
        List<SObject> orderitems = TestDataFactory.getOrderItemCreator()
                .addOverrideValue('accountid', accounts[0].Id)
                .addOverrideValue('pricebookentryid', pbentries[0].Id)
                .addOverrideValue('orderid', orders[0].Id)
                .addOverrideValue('vlocity_cmt__fulfilmentstatus__c', 'In Progress')
                .addOverrideValue('vlocity_cmt__assetreferenceid__c', '12345')
                .createMultipleObjects(5);
        orderitems.addAll(TestDataFactory.getSObjectCreator(Schema.OrderItem.SObjectType)
                .addOverrideValue('accountid', accounts[0].Id)
                .addOverrideValue('pricebookentryid', pbentries[0].Id)
                .addOverrideValue('vlocity_cmt__fulfilmentstatus__c', 'In Progress')
                .addOverrideValue('vlocity_cmt__assetreferenceid__c', '12345')
                .createMultipleObjectsforParents(1, orders, 'orderid'));
        insert orderitems;

        SObject tasks = TestDataFactory.getSObjectCreator(Schema.Task.SObjectType)
                .createObject();
        insert tasks;

    }

    public static String getUniqueUsername() {
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueOf(Datetime.now()).replace(' ', '').replace(':', '').replace('-', '');
        Integer randomInt = Integer.valueOf(Math.rint(Math.random() * 1000000));
        String uniqueName = orgId + dateString + randomInt;
        return uniqueName + '@test' + orgId + '.org';
    }
}