trigger ContactTrigger on Contact (after insert, after update, after delete) {
    contactTriggerHandler.handleContactChanges(
        Trigger.new, 
        Trigger.oldMap, 
        Trigger.isDelete
    );
}