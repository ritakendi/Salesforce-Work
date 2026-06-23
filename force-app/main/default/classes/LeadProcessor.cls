global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    public integer leadsUpdated = 0;

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Name,Company,LastName FROM Lead');
    }

    public void execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead ld : scope){
            ld.LeadSource = 'Dreamforce';
            leadsUpdated+=1;
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, JobItemsProcessed, TotalJobItems FROM AsyncApexJob WHERE Id =:bc.getJobId()];
        //call some utility to send email
         EmailManager.sendMail('kendibrita@gmail.com',
                          leadsUpdated + ' Leads were Updated!',
                          'Meet me at the bar for drinks to celebrate');
    }
}