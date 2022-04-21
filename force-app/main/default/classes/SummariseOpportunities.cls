public class SummariseOpportunities {
    public static void sumOpportunities() {
        //Variables to hold opportunities count and amount values
        Integer oppCount=0;
        Double oppAmt = 0;
        Double oldOppAmt =0;
        Double newOppAmt =0;
        //Calling the getOpportunities method to retrive opportunities that were created in CollectionsExercise
        List < Opportunity > oppList = CollectionsExercise.getOpportunities();
        /*List < AggregateResult > results = [select AccountId, Account.Name Name, count(Id) OpptyCount, Sum(Amount) OpptyAmount
                                            from Opportunity group by AccountId, Account.Name
                                           ];*/
        //Map<Id, String> valuesMap = new Map<Id, String>();
        //Maps to collect opportunity counts and sum of amounts for each opportunities related with the given account
        Map < String, Integer > opportunityCounts = new Map < String, Integer > ();
        Map < String, Double > opportunityAmounts = new Map < String, Double > ();
        //Getting the list of account ids
        List<Account> accList = [SELECT Id FROM Account];
        Set <Id> accIds = (new Map<Id,SObject>(accList)).keySet();
       	System.debug('Account Ids: '+accIds);
        //The real stuff begins
        for(Id accId: accIds){
            System.debug('Inside loop');
            for(Opportunity op:oppList){
                if(op.AccountId == accId){     
                    oppCount++;
                    newOppAmt = op.Amount + oldOppAmt;             
                    System.debug('Condition success:'+ 'Opportunity Name: '+op.Name+', Account Name: '+op.Account.Name +' ,Opp Count: '+oppCount+ ', Opp Amt: '+newOppAmt);                                   	
                	//String accName = (String) op.get('AccountId');
                	opportunityCounts.put(op.Account.Name,oppCount);
                    opportunityAmounts.put(op.Account.Name,newOppAmt);
                } 
                oldOppAmt= newOppAmt; 
            }
            //Resetting the holder variables for the other account's opportunities
            oldOppAmt = 0; 
            newOppAmt = 0;
            oppAmt=0;
            oppCount=0;
        }
        //Printing the maps
        System.debug('Opportunities count map: '+opportunityCounts);
        System.debug('Opportunities amount map: '+opportunityAmounts);
    }
}