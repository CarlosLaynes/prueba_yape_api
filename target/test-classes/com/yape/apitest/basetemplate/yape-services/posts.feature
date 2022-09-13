Feature: Yape Collection Post, Put, Patch, Delete

Background: 
* url 'https://restful-booker.herokuapp.com/auth'
And header Content-Type = 'application/json'
And request { "username": "admin", "password": "password123"}
When method POST
Then status 200
And print response
* def token = response.token
* print token


Scenario: Booking - CreateBooking
Given url 'https://restful-booker.herokuapp.com/booking'
And header Content-Type = 'application/json'
And header Accept = 'application/json'
And request { "firstname" : "Jim", "lastname" : "Brown", "totalprice" : 111, "depositpaid" : true, "bookingdates" : {     "checkin" : "2018-01-01",     "checkout" : "2019-01-01" }, "additionalneeds" : "Breakfast" }
When method POST
Then status 200
And print response

Scenario: Booking - UpdateBooking
* url 'https://restful-booker.herokuapp.com/booking'
When method GET
Then status 200
And print response
* def booking = karate.jsonPath(response, "$..bookingid" )[0]
* print booking
Given url 'https://restful-booker.herokuapp.com/booking/' +booking
And header Content-Type = 'application/json'
And header Accept = 'application/json'
And header Cookie = 'token=' +token
And request { "firstname" : "Jim", "lastname" : "Brown", "totalprice" : 111, "depositpaid" : true, "bookingdates" : {     "checkin" : "2018-01-01",     "checkout" : "2019-01-01" }, "additionalneeds" : "Breakfast" }
When method PUT
Then status 200
And print response

Scenario: Booking - PartialUpdateBooking
* url 'https://restful-booker.herokuapp.com/booking'
When method GET
Then status 200
And print response
* def booking = karate.jsonPath(response, "$..bookingid" )[0]
* print booking
Given url 'https://restful-booker.herokuapp.com/booking/' +booking
And header Content-Type = 'application/json'
And header Accept = 'application/json'
And header Cookie = 'token=' +token
And request { "firstname" : "Jim", "lastname" : "Brown"}
When method PATCH
Then status 200
And print response

Scenario: Booking - DeleteBooking
* url 'https://restful-booker.herokuapp.com/booking'
When method GET
Then status 200
And print response
* def bookingDelete = karate.jsonPath(response, "$..bookingid" )[2]
* print bookingDelete
Given url 'https://restful-booker.herokuapp.com/booking/' +bookingDelete
And header Content-Type = 'application/json'
And header Accept = 'application/json'
And header Cookie = 'token=' +token
When method DELETE
Then status 201
And print response
And match response == "Created"
