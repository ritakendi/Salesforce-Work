trigger ApplicationTrigger on Application__c (before insert, before update) {
    ApplicationTriggerHandler.setFees(Trigger.new);
}