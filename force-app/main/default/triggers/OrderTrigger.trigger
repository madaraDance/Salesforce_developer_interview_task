trigger OrderTrigger on Order (after insert) {
    
    if (Trigger.isInsert){
        if (Trigger.isAfter){
            List<Order> newOrders = Trigger.new;
            InvoiceCreation.InvoiceCreationInsert(newOrders);
        }
    }

    /* First version of the program.
    
    List<Invoice__c> newInvoices = new List<Invoice__c>();
        
    for (Order newOrder : Trigger.new)  {
        Invoice__c newInvoice = new Invoice__c(Order__c = newOrder.Id);
        newInvoices.add(newInvoice);
    }
        
    insert newInvoices;
    */
}