Feature: Yape Collection Get

Background: Booking - GetBookingIds
* url 'https://restful-booker.herokuapp.com/booking'
When method GET
Then status 200
And print response
* def booking = karate.jsonPath(response, "$..bookingid" )[0]
* print booking
* def bookingDelete = karate.jsonPath(response, "$..bookingid" )[2]


Scenario: Booking - GetBooking
Given url 'https://restful-booker.herokuapp.com/booking/' + booking
And header Accept = 'application/json'
When method GET
Then status 200
And print response

Scenario: Ping - HealthCheck
Given url 'https://restful-booker.herokuapp.com/ping'
When method GET
Then status 201
And print response
And match response == "Created"

