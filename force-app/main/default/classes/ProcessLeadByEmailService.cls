global class ProcessLeadByEmailService implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result=new Messaging.InboundEmailResult();
        
        List<Lead> leadsToInsert = new List <Lead>();
        Lead instanceLead = new Lead();

        instanceLead.FirstName = email.fromName.substring(0,email.fromName.indexOf(''));
        instanceLead.LastName = email.fromName.substring(email.fromAddress.indexOf(''));
        instanceLead.Company = instanceLead.FirstName + '' + instanceLead.LastName;
        instanceLead.Email = envelope.fromAddress;

        leadsToinsert.add(instanceLead);
        insert leadsToinsert;

        if(email.binaryAttachments!=null && email.binaryAttachments.size()>0) {
            list<Attachment> attachmentsToInsert = new List <Attachment>();
            for(integer i=0; i< email.binaryAttachments.size(); i++){

                Attachment attachment = new Attachment();
                attachment.ParentId = instanceLead.Id;
                attachment.Name = email.binaryAttachments[i].filename;
                attachment.body = email.binaryAttachments[i].body;
                attachmentsToInsert.add(attachment);
            }
            insert attachmentsToInsert;
        }
        return result;
        
    }
}