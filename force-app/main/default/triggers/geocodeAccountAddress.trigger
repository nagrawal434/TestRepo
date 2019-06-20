trigger geocodeAccountAddress on Account (after insert, after update){
    for(Account account : trigger.new){
        Boolean addressChangedFlag = false;
        if(Trigger.isUpdate) {
            Account oldAccount = Trigger.oldMap.get(account.Id);
            if((account.BillingStreet != oldAccount.BillingStreet) || (account.BillingCity != oldAccount.BillingCity) || (account.BillingCountry != oldAccount.BillingCountry) || (account.BillingPostalCode != oldAccount.BillingPostalCode)){
                addressChangedFlag = true;
                System.debug(LoggingLevel.DEBUG, '***Address changed for - ' + oldAccount.Name);
            }
        }
        if((account.Location__Latitude__s == null) || (addressChangedFlag)){
            System.debug(LoggingLevel.DEBUG,'***Geocoding Account - ' + account.Name);
            AccountGeocodeAddress.DoAddressGeocode(account.id);
        }
    }
}