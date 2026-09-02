trigger OpportunityTrigger on Opportunity (before insert) {
    OpportunityTriggerHandler.setHighestAmount(Trigger.new);
}