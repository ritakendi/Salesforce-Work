public with sharing class DescribePractice {
    public static void printAccountFields() {
        Map<String, Schema.SObjectField> fields =
            Schema.SObjectType.Account.fields.getMap();
        System.debug('Total fields on Account: ' + fields.size());

        for (String fieldName : fields.keySet()) {
            Schema.describeFieldResult fieldDescribe = fields.get(fieldName).getDescribe();
            System.debug(
                'Field: ' + fieldDescribe.getName() +
                ' | Type: ' + fieldDescribe.getType() +
                ' | Label: ' + fieldDescribe.getLabel() +
                ' | Custom: ' + fieldDescribe.isCustom()
            );
        }
    }
}