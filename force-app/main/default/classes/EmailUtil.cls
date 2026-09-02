public class EmailUtil {

    // Send a single email to one or more recipients
    public static void sendEmail(String toAddress, String subject, String body) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] {toAddress});
        email.setSubject(subject);
        email.setPlainTextBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }

    // Send bulk emails to multiple recipients
    public static void sendEmails(List<String> toAddresses, String subject, String body) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(String addr : toAddresses) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] {addr});
            email.setSubject(subject);
            email.setPlainTextBody(body);
            emails.add(email);
        }
        Messaging.sendEmail(emails);
    }
}