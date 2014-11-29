EatSmart API Docs
===============================

### Version
0.2.1b

#meals
## create meal event
    /<versionNumber>/meals/create
This functions will create a new meal event.
Required POST fields are:
* String name
* String date (Format %Y-%m-%d %H:%M:%S)
* String dateRegistrationEnd (Format %Y-%m-%d %H:%M:%S)
* Integer maxGuests
* Double price (in €)
* String address
* String typ (for now "food" or "cooking")
* Integer Host ID
    
## delete meal event
    /<versionNumber>/meals/<mealId>
Call this url with a DELETE Http-Request to delete that meal

##get meal information
    /<versionNumber>/meals/<mealId>
Call with GET to get infromation. Return values are:
    
    String mealId
    String typ
    String date
    String dateRegistrationEnd
    Double price
    String place address
    Dictionary placeGPS
        Float latitude
        Float longitude
    Integer maxGuests
    Integer guest_attending
    Dictionary host
        String hostname
        Integer age
        String phone
        String gender
        String dateRegisteredSince
        Integer userID
        String imageUrl

## add user to meal
    /<versionNumber>/meals/<mealId>/users/<userId>
Call this url with a POST request to add a user to a meal

##remove user from meal
    /<versionNumber>/meals/<mealId>/users/<userId>
call with DELETE to remove user from meal


##search for meal close by
    /<versionNumber>/meals/search/<float:latitude>/<float:longitude>
Call with your gps position to get meals close to you
Return values:

