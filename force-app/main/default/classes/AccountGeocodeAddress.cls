public class AccountGeocodeAddress {
    
    // static variable to determine if geocoding has already occurred
    private static Boolean geocodingCalled = false;
    // wrapper method to prevent calling future methods from an existing future context
    public static void DoAddressGeocode(id accountId){
        if(geocodingCalled || System.isFuture()) {
            System.debug(LoggingLevel.WARN,'***Address Geocoding Future Method Already Called - Aborting...');
            return;
        }
        // if not being called from future context, geocode the address
        geocodingCalled = true;
        geocodeAddress(accountId);
    }
    
    // we need a future method to call Google Geocoding API from Salesforce
    @future (callout=true)
    static private void geocodeAddress(id accountId){ 
        // Key for Google Maps Geocoding API
        String geocodingKey = 'AIzaSyALuBmcWQVihipNhi43OrXh-0Q7lnJ8b5U';
        // get the passed in address
        Account geoAccount = [SELECT BillingStreet, BillingCity, BillingState, BillingCountry,BillingPostalCode FROM Account WHERE id = :accountId];
        
        //check that we have enough information to geocode the address
        if((geoAccount.BillingStreet == null) || (geoAccount.BillingCity == null)) {
            System.debug(LoggingLevel.WARN,'Insufficient Data to Geocode Address');
            return;
        }
        //create a string for the address to pass to Google Geocoding API
        String geoAddress = '';
        if(geoAccount.BillingStreet != null)
            geoAddress += geoAccount.BillingStreet + ', ';
        if(geoAccount.BillingCity != null)
            geoAddress += geoAccount.BillingCity + ', ';
        if(geoAccount.BillingState != null)
            geoAddress += geoAccount.BillingState + ', ';
        if(geoAccount.BillingCountry != null)
            geoAddress += geoAccount.BillingCountry + ', ';
        if(geoAccount.BillingPostalCode != null)
            geoAddress += geoAccount.BillingPostalCode;
      
        //encode the string so we can pass it as part of URL
        geoAddress = EncodingUtil.urlEncode(geoAddress, 'UTF-8');
        //build and make the callout to the Geocoding API
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://maps.googleapis.com/maps/api/geocode/json?address=' + geoAddress + '&key=' + geocodingKey + '&sensor=false');
        request.setMethod('GET');
        request.setTimeout(60000);
        try{
            string JSONString='';
            HttpResponse response;
            if(!Test.isRunningTest()){
            // make the http callout
                response = http.send(request);
                JSONString = response.getBody();
                System.debug('@@@' + response.getBody());
            }else{
                System.debug('@@@' + response.getBody());
                JSONString = '{"location" : {"lat" : 26.4716456,"lng" : 74.63528549999999}}';
            }
            // parse JSON to extract co-ordinates
            JSONParser responseParser = JSON.createParser(JSONString);
            //system.debug('###'+response.getBody());
            // initialize co-ordinates
            double latitude = null;
            double longitude = null;
             while(responseParser.nextToken() != null) {
                if((responseParser.getCurrentToken() == JSONToken.FIELD_NAME) && (responseParser.getText() == 'location')) {
                    responseParser.nextToken();
                    while(responseParser.nextToken() != JSONToken.END_OBJECT) {
                        String locationText = responseParser.getText();
                        responseParser.nextToken();
                        if (locationText == 'lat')
                            latitude = responseParser.getDoubleValue();
                        else if (locationText == 'lng')
                            longitude = responseParser.getDoubleValue();
                    }
                 }
              }
              // update co-ordinates on address if we get them back
              if(latitude != null) {
                  geoAccount.Location__Latitude__s = latitude;
                  geoAccount.Location__Longitude__s = longitude;
                  update geoAccount;
             }
        }catch(Exception e) {
            System.debug(LoggingLevel.ERROR,'Error Geocoding Address - ' + e.getMessage());
        }
    }
}