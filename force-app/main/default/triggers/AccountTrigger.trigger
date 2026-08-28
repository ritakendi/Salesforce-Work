trigger AccountTrigger on Account (before insert, before update) {
    AccountTriggerHandler.CreateAccounts(Trigger.new);
}