public with sharing class OpportunityTriggerHandler {
    public static void setHighestAmount(List<Opportunity> newOpportunities) {
        Decimal highestAmount = 0;
        AggregateResult ar = [
            SELECT MAX(Amount) maxAmount 
            FROM Opportunity
        ];
            if (ar.get('maxAmount') != null) {
                highestAmount = (Decimal) ar.get('maxAmount');
            }
            
            for (Opportunity opp : newOpportunities) {
                opp.Current_Highest_Amount__c = highestAmount;
            }
    }
}