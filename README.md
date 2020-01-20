# sf-test-data-factory
Test data factory for Salesforce

# Usage
### Create single instance with default builder for object
```Account account = (Account) TestDataFactory.getAccountCreator().createObject();```

### Create single instance with override values with default builder for object
```
  Account account = (Account) TestDataFactory.getAccountCreator().createObject();
  Insert account;
  SObject contact = TestDataFactory.getContactCreator()
            .addOverrideValue('AccountId', account.Id)
            .addOverrideValue('email', TEST_CONTACT_EMAIL)
            .createObject();
```

### Create sobject when no default builder exists
```
  Account account = (Account) TestDataFactory.getsObjectCreator(Schema.Account.sObjectTyp).createObject();

```

### Create mulitple sobject
```
  List<Account> accounts = (List<Account>) TestDataFactory.getAccountCreator().createMultipleObjects(100);

```
