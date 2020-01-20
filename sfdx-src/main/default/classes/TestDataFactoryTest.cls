@IsTest(isParallel = false)
private class TestDataFactoryTest {
    @IsTest
    private static void testInsert() {
        List<sObject> accounts = [SELECT id FROM Account];
        List<sObject> contacts = [SELECT Id FROM Contact];
        List<sObject> cases = [SELECT Id FROM Case];
        List<sObject> products = [SELECT Id FROM Product2];
        List<sObject> pbentries = [SELECT Id FROM PriceBookEntry];
        List<sObject> orders = [SELECT Id FROM Order];
        List<sObject> orderitems = [SELECT Id FROM OrderItem];
        List<sObject> tasks = [SELECT Id FROM Task];
        List<sObject> users = [SELECT Id FROM User];
        System.assertNotEquals(accounts.size(), 0,'Expected accounts to be created');
        System.assertNotEquals(contacts.size(), 0,'Expected contacts to be created');
        System.assertNotEquals(cases.size(), 0,'Expected cases to be created');
        System.assertNotEquals(products.size(), 0,'Expected products to be created');
        System.assertNotEquals(pbentries.size(), 0,'Expected pbentries to be created');
        System.assertNotEquals(orders.size(), 0,'Expected orders to be created');
        System.assertNotEquals(orderitems.size(), 0,'Expected orderitems to be created');
        System.assertNotEquals(tasks.size(), 0,'Expected Task to be created');
        System.assertNotEquals(users.size(), 0,'Expected User to be created');
    }

    @testSetup
    private static void testDataSetup() {
        //Create Account
        List<sObject> accounts = TestDataFactory.getAccountCreator().createMultipleObjects(5);
        //Create Account via generic method
        accounts.addAll(TestDataFactory.getsObjectCreator(Schema.Account.sObjectType).createMultipleObjects(1));
        Insert accounts;
        //Create Contacts
        List<sObject> contacts = TestDataFactory.getContactCreator()
                                 .addOverrideValue('accountid', accounts[0].id)
                                 .createMultipleObjects(5);
        contacts.addAll(TestDataFactory.getsObjectCreator(Schema.Contact.sObjectType)
                                 .addOverrideValue('accountid', accounts[0].id)
                                 .createMultipleObjects(1));
        Insert contacts;
        //Create Case
        List<sObject> caseRecords = TestDataFactory.getCaseCreator()
                                   .addOverrideValue('accountid', accounts[0].id)
                                   .createMultipleObjects(5);
        //Create Case via generic method
        caseRecords.addAll(TestDataFactory.getsObjectCreator(Schema.Case.sObjectType)
                          .addOverrideValue('accountid', accounts[0].id)
                          .createMultipleObjects(1));
        Insert caseRecords;
        //Create product
        List<sObject> products =  TestDataFactory.getProductCreator().createMultipleObjects(2);
        products.addAll(TestDataFactory.getsObjectCreator(Schema.Product2.sObjectType).createMultipleObjects(1));
        Insert products;
        //Get Standard Pricebook Id
        id pricebookId = Test.getStandardPricebookId();
        List<sObject> pbentries = TestDataFactory.getPriceBookEntryCreator()
                                  .addOverrideValue('pricebook2id',pricebookId)
                                  .addOverrideValue('product2id',products[0].id)
                                  .createMultipleObjects(1);
        pbentries.add(TestDataFactory.getsObjectCreator(Schema.PriceBookEntry.sObjectType)
                      .addOverrideValue('pricebook2id',pricebookId)
                      .addOverrideValue('product2id',products[1].id)
                      .createObject());
        Insert pbentries;
        //Create Order
        List<sObject> orders = TestDataFactory.getOrderCreator()
                               .addOverrideValue('accountid', accounts[0].id)
                               .addOverrideValue('pricebook2id', pricebookId)
                               .createMultipleObjects(5);
        orders.addAll(TestDataFactory.getsObjectCreator(Schema.Order.sObjectType)
                               .addOverrideValue('accountid', accounts[0].id)
                               .addOverrideValue('pricebook2id', pricebookId)
                               .createMultipleObjects(1));
        Insert orders;
        //Create orderItems
        List<sObject> orderitems = TestDataFactory.getOrderItemCreator()
                                   .addOverrideValue('accountid', accounts[0].id)
                                   .addOverrideValue('pricebookentryid', pbentries[0].id)
                                   .addOverrideValue('orderid', orders[0].id)
                                   .addOverrideValue('vlocity_cmt__fulfilmentstatus__c', 'In Progress')
                                   .addOverrideValue('vlocity_cmt__assetreferenceid__c', '12345')
                                   .createMultipleObjects(5);
        orderitems.addAll(TestDataFactory.getsObjectCreator(Schema.OrderItem.sObjectType)
                                   .addOverrideValue('accountid', accounts[0].id)
                                   .addOverrideValue('pricebookentryid', pbentries[0].id)
                                   .addOverrideValue('vlocity_cmt__fulfilmentstatus__c', 'In Progress')
                                   .addOverrideValue('vlocity_cmt__assetreferenceid__c', '12345')
                                   .createMultipleObjectsforParents(1, orders, 'orderid'));
        Insert orderitems;
        sObject tasks = TestDataFactory.getsObjectCreator(Schema.Task.sObjectType)
                                   .createObject();
        Insert tasks;
		
        // Create users
        Id profileId = [Select Id from Profile where Name = 'Trial Customer Portal User'].Id;
		
        //Create User
        List<sObject> userRecords = TestDataFactory.getUserCreator()
                                    .addOverrideValue('ContactId', contacts[0].Id)
                                    .addOverrideValue('FirstName', 'test')
                                    .addOverrideValue('LastName', 'contact')
                                    .addOverrideValue('Email', 'test@gmail.com')
                                    .addOverrideValue('Username', 'test@gmail.com')
                                    .addOverrideValue('ProfileId', profileId)
                                    .addOverrideValue('CommunityNickname', 'test@gmail.com')
                                    .addOverrideValue('Alias', 'contact')
                                    .addOverrideValue('IsActive', true)
                                    .createMultipleObjects(1);
        
        //Create User via generic method
        userRecords.add(TestDataFactory.getsObjectCreator(Schema.User.sObjectType)
                        .addOverrideValue('ContactId', contacts[1].Id)
                        .addOverrideValue('FirstName', 'test')
                        .addOverrideValue('LastName', 'contact')
                        .addOverrideValue('Email', 'test1@gmail.com')
                        .addOverrideValue('Username', 'test1@gmail.com')
                        .addOverrideValue('ProfileId', profileId)
                        .addOverrideValue('CommunityNickname', 'test1@gmail.com')
                        .addOverrideValue('Alias', 'contact1')
                        .addOverrideValue('IsActive', true)
                        .createObject());
        
        Insert userRecords;
    }
}