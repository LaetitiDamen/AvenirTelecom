
@isTest
public with sharing class testProcessLeadByEmailService {

    @isTest
    static void testProcessLeadByEmailService() {

        // create a new email and envelope object
Messaging.InboundEmail email = new Messaging.InboundEmail() ;
Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

// setup the data for the email
email.subject = 'Test Job Applicant';
email.fromname = 'FirstName LastName';
env.fromAddress = 'someaddress@email.com';

// add an attachment
Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
attachment.body = blob.valueOf('my attachment text');
attachment.fileName = 'textfile.txt';
attachment.mimeTypeSubType = 'text/plain';

email.binaryAttachments =
new Messaging.inboundEmail.BinaryAttachment[] { attachment };

// call the email service class and test it with the data in the testMethod
ProcessLeadByEmailService emailProcess = new ProcessLeadByEmailService();
emailProcess.handleInboundEmail(email, env);
// query for the contact the email service created
Lead lead = [select id, firstName, lastName, email from lead
where firstName = 'FirstName' and lastName = 'LastName'];

System.assertEquals(lead.firstName,'FirstName');
System.assertEquals(lead.lastName,'LastName');
System.assertEquals(lead.email,'someaddress@email.com');

// find the attachment
Attachment a = [select name from attachment where parentId = :lead.id];

System.assertEquals(a.name,'textfile.txt');

    }
}
