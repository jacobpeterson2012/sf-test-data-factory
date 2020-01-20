# sf-test-data-factory
Test data factory for Salesforce

# Usage
### Create single instance with default builder for object
```Account account = (Account) TestDataFactory.getAccountCreator().createObject();```

### Create single instance with override values
```Account account = (Account) TestDataFactory.getAccountCreator().createObject();
  Insert account;
  SObject contact = TestDataFactory.getContactCreator()
            .addOverrideValue('AccountId', account.Id)
            .addOverrideValue('email', TEST_CONTACT_EMAIL)
            .createObject();;```

