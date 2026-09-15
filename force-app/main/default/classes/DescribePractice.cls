public class DescribePractice {
    public static void printAccountFields() {
        Map<String, Schema.SObjectField> fields =
            Schema.SObjectType.Account.fields.getMap();

        System.debug('Total fields on Account: ' + fields.size());

        for (String key : fields.keySet()) {
            Schema.DescribeFieldResult d = fields.get(key).getDescribe();

            System.debug(
                'Field: ' + d.getName() +
                ' | Type: ' + d.getType() +
                ' | Label: ' + d.getLabel() +
                ' | Custom: ' + d.isCustom()
            );
        }
    }
    public static void printAccountRecordTypes() {
        Schema.DescribeSObjectResult accMtd = Schema.SObjectType.Account.getDescribe();
        Schema.RecordTypeInfo[] recordTypeInfos = accMtd.getRecordTypeInfos();

        for (Schema.RecordTypeInfo rti : recordTypeInfos) {
            System.debug{
                'Record Type Name: ' + rti.getName() +
                ' | Record Type Id: ' + rti.getRecordTypeId() +
                ' | Is Active: ' + rti.isActive() +
                ' | Is Default: ' + rti.isDefaultRecordTypeMapping() +
                ' | Developer Name: ' + rti.getDeveloperName() +
                ' | isAvailable: ' + rti.isAvailable()
            };
        }
    }
}