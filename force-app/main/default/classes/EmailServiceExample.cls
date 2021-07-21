global class EmailServiceExample implements Messaging.InboundEmailHandler{
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email,Messaging.InboundEnvelope envelope)
     {
      // Create an InboundEmailResult object for returning the result of the Apex Email Service
      Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
      try 
      {
       List<Contact> leadsToInsert= [SELECT Id, Name, Email FROM Contact WHERE Email = :email.fromAddress LIMIT 1];
       Lead instanceLead = new Lead();
       instanceLead.Description =  email.plainTextBody;
       instanceLead.Status = 'Inbound Email';
       instanceLead.Subject = email.subject;
       instanceLead.FirstName = email.fromName.substring(0,email.fromName.indexOf(''));
       instanceLead.LastName = email.fromName.substring(email.fromAddress.indexOf(''));
       instanceLead.Company = instanceLead.FirstName + '' + instanceLead.LastName;
      

       if(leadsToInsert.size()>0)
       {
        instanceLead.WhoId =  leadsToInsert[0].Id;
       }    
       insert instanceLead;    
      }
      catch (Exception e)
     
      {
         System.debug('Exception : ' + e);
      }
      result.success = true;
      return result;
     }
    
}