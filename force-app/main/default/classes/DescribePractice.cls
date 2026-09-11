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
}