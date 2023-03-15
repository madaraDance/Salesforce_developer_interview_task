@isTest
public class TestOrderTrigger {

    @isTest 
    static void testOneInvoiceCreation(){
        Account testAccount = new Account(Name = 'Boooo');
        insert testAccount;

        Order testOrder = new Order(AccountId = testAccount.Id, EffectiveDAte = date.today(), Status = 'Draft');

        Test.startTest();
        insert testOrder;
        Test.stopTest();

        List<Invoice__c> result = [SELECT Order__c FROM Invoice__c WHERE Order__c = :testOrder.Id];

        System.debug(result);
        System.assert(result.size() == 1, 'Invoice was not created'); // When given condtition evaluates as false, prints the message.
    }

    @isTest static void testInvoiceCreation() {
        Integer ordersToCreate = getRandomNumber();

        List<Account> testAccounts = new List<Account>();

        for (integer i = 0; i < ordersToCreate; i++){
            Account testAccount = new Account(Name = 'TestName' + i);
            testAccounts.add(testAccount);
        }

        insert testAccounts;

        List<Order> testOrders = new List<Order>();
        for (integer i = 0; i < ordersToCreate; i++){
            Order testOrder = new Order(AccountId = testAccounts[i].Id, EffectiveDAte = date.today(), Status = 'Draft');
            testOrders.add(testOrder);
        }

        Test.startTest();
        insert testOrders;
        Test.stopTest();

        List<Invoice__c> result =  new List<Invoice__c>();
        for (integer i = 0; i < ordersToCreate; i++){
            result.add([SELECT Order__c FROM Invoice__c WHERE Order__c = :testOrders[i].Id]);
        }

        System.debug('Number of new orders created: ' + ordersToCreate);
        System.debug(result);

        System.assert(result.size() == ordersToCreate, 'Number of created invoices is not correct.\n' +
            'Expected to create : ' + ordersToCreate + '\n' +
            'But created only: ' + result.size()); 
    }
    
    static Integer getRandomNumber(){
        return Integer.valueof((Math.random() * 9) + 2); // generates a number from 1 to 10.
    }
}