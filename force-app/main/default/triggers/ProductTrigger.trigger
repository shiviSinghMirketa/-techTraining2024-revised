trigger ProductTrigger on Product2 (after insert) {
    List<New_Product_entry__e> npeList = new List<New_Product_entry__e> ();
    for(Product2 prod: trigger.new){
        New_Product_entry__e npe =new New_Product_entry__e();
        npe.ProductName__c = 'Gucci Perfume';
        npe.ProductCategory__c = prod.Family;
        npe.ProductId__c = prod.Id;
        npe.ProductPrice__c = 130;
        npeList.add(npe);
    }
    System.debug('-----npeList-----' + npeList);
    List<Database.SaveResult> results = EventBus.publish(npeList);
}