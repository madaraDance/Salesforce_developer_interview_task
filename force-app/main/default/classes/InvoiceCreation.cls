public class InvoiceCreation {
    public static void InvoiceCreationInsert(List<Order> newOrders) {
        
        List<Invoice__c> newInvoices = new List<Invoice__c>();
            
        for (Order newOrder : newOrders)  {
            Invoice__c newInvoice = new Invoice__c(Order__c = newOrder.Id);
            newInvoices.add(newInvoice);
        }
            
        insert newInvoices;
    }
}