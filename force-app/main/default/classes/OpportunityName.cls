public with sharing class OpportunityName {
    public  void OpportunityName(List<Opportunity> NewOpps) {

        List<Id> oppIds = new List<Id>();
        for (Opportunity opp:NewOpps ){
             oppIds.add(opp.Id);
        }
    List<Opportunity> oppr = [select id , CreatedDate, Name,Account.Name From Opportunity Where id in :oppIds];
                  for(Opportunity opps : oppr){
                        Datetime myDate = Datetime.CreatedDate();
                        //[select id, CreatedDate from Opportunity where CreatedDate < TODAY];
                        //Datetime myDate = date.CreatedDate();
                        Integer month = myDate.month();
                        Integer day = myDate.day();
                        Integer year = myDate.year();
                        opps.Name = (opps.Name +'::'+ opps.Account.Name +'::' +' '+day+'-'+month+ '-'+year+'');
                    }       
 
    Update oppr;


    }
}
