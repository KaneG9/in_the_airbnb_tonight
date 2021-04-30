MakersBnB
=================
Challenge:
 -------
Builld a web application clone of AirBnB that allows users to list spaces they have available, and to hire spaces for the night.

By the end of the week, the goal is to be able to answer "yes" to the week's primary question:

- Can you, with only a specification to guide you, work as part of a team to build a web app?



<p>&nbsp;</p>

 Completed Features:
 -------
 - [x] Sign up / Log in / Log out
 - [x] Add a property
 - [x] View a property
 - [x] Book a property - see pending and confirmed booking requests
 - [x] Message sent to owner account upon rental request
 - [x] Message sent to renter after rental request approval
<p>&nbsp;</p>

## Tech Stack
Frontend
* HTML
* CSS

Backend
* Ruby
* Sinatra web framework
* PostgreSQL

Testing
* RSpec
* Capybara 
<p>&nbsp;</p>

## How to install and run
<p>&nbsp;</p>

### Project Setup
```
git clone https://github.com/MattDawson2020/in_the_airbnb_tonight.git

bundle
```
### Database Setup
```
rake setup
```
### Run App
App is hosted on localhost:9292
```
rackup
```

### Run Tests
```
rspec
```

### Run Linting
```
rubocop
```
<p>&nbsp;</p>

## User Interface Flow

<details>
  <summary> Sign up </summary>
    <img src="/public/images/user_interface/sign_up.png">
    <br>
    Flash error if email used is not unique 
    <br>
    <img src="/public/images/user_interface/signup_error_flash.png">
    <br>
</details>

<details>
  <summary> Sign in </summary>
    <img src="/public/images/user_interface/sign_in.png">
    <br>
    <img src="/public/images/user_interface/incorrect_login_flash.png">
    <br>
</details>

<details>
  <summary> Listings homepage </summary>
    <img src="/public/images/user_interface/listings_homepage.png">
    <br>
</details>

<details>
  <summary> List a new property </summary>
    <img src="/public/images/user_interface/list_property.png">
    <br>
</details>

<details>
  <summary> View a property </summary>
    <img src="/public/images/user_interface/property_description_page.png">
    <br>
</details>

<details>
  <summary> Request to rent a property </summary>
    <img src="/public/images/user_interface/make_booking.png">
    <br>
    Booking status set to pending review <br>
    <img src="/public/images/user_interface/rental_request_sent.png">
    <br>
    Dates in past trigger error <br>
    <img src="/public/images/user_interface/date_in_past_flash.png">
    <br>
</details>

<details>
  <summary> Property request message received </summary>
    Property owner messages view <br>
    <img src="/public/images/user_interface/rental_request_message.png">
    <br>
</details>

<details>
  <summary> Property request approved </summary>
    Renter messages view <br>
    <img src="/public/images/user_interface/request_approved_message.png">
    <br>
</details>

<details>
  <summary> Booking status updated </summary>
    <img src="/public/images/user_interface/booking_status_updated.png">
    <br>
</details>

<details>
  <summary> Logout </summary>
    <img src="/public/images/user_interface/logout.png">
    <br>
</details>

<p>&nbsp;</p>

## Planning


### Project Management

<a href="https://trello.com/b/PyreuO8R/workflow">Trello board</a>
<p>&nbsp;</p>

### Specification
<details>
<summary> Headline </summary>
<br>
<ul>
<li>Any signed-up user can list a new space.</li>
<li>Users can list multiple spaces.</li>
<li>Users should be able to name their space, provide a short description of the <li>space, and a price per night.</li>
<li>Users should be able to offer a range of dates where their space is available.</li>
<li>Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.</li>
<li>Nights for which a space has already been booked should not be available for users to book that space.</li>
<li>Until a user has confirmed a booking request, that space can still be booked for that night.</li>
</ul>
</details>


<details>
<summary> Nice-to-haves </summary>
<br>
<ul>
Users should receive an email whenever one of the following happens:
<li>They sign up</li>
<li>They create a space</li>
<li>They update a space</li>
<li>A user requests to book their space</li>
<li>They confirm a request</li>
<li>They request to book a space</li>
<li>Their request to book a space is confirmed</li>
<li>Their request to book a space is denied</li><br>
Users should receive a text message to a provided number whenever one of the following happens:
<li>A user requests to book their space</li>
<li>Their request to book a space is confirmed</li>
<li>Their request to book a space is denied </li> <br>
<li>A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space</li>
<li>Basic payment implementation though Stripe.</li><br>
</ul>
</details>
<p>&nbsp;</p>

### Outline of MVP
* Users can sign up/in/out
* Signed up user can list a space
* Signed up user can request to rent a space
* Signed up user can approve or deny a booking request on their listing
* Signed up user can see their booking confirmed
* Basic styling
<p>&nbsp;</p>

### User Stories
```
CREATE ACCOUNT

As a user 
so I can manage my bookings
I can sign up to MBNB
 
As a user 
so I can manage my account
I can sign in and out of MBNB
```
```
LISTING
 
As an owner 
So I can advertise my property
I can add a property listing to MBNB
 
As an owner 
So I can make my property listing distinctive
I can add descriptive attributes to a property listing
 
As an owner 
So I can advertise all my properties
I can add multiple property listings to MBNB
```
```
RENTING
 
As a renter
So I can plan my accommodation
I can look at properties to hire
 
As a renter
So I can get accomodation
I can submit a request to hire a property
 
As an owner
So I can rent my property
I can view and approve rental requests
 
As a renter
So I know that my request has been approved
I can see a confirmation that I have been approved to book
```
```
CALENDAR / AVAILABILITY
 
As an owner 
So I can display the availability of my property
I can display a range of dates for when the property is available 
 
As a user
So that I can book available spaces
I can see when a property is already booked/unavailable
 
As an owner
So that my property isn’t double booked
Once a booking is confirmed my property becomes unavailable for those dates
 
As an owner
So that I can maximise my business opportunities
I can continue to advertise my property as available until booking is confirmed
```
<p>&nbsp;</p>

### Domain Model

<details>
<summary>Create an account user stories </summary>
<br>
<img src="/public/images/makersBnB_create_account.png">
</details>

<details>
<summary>Create a listing user stories </summary>
<br>
<img src="/public/images/makersBnB_create_listing.png">
</details>


<details>
<summary>Rent a property user stories </summary>
<br>
<img src="/public/images/makersBnB_rent_a_property.png">
</details>

<p>&nbsp;</p>

## Reflections


<p>&nbsp;</p>

## Built by:
* Matt Dawson | [GitHub](https://github.com/MattDawson2020)
* Kane Gin | [GitHub](https://github.com/KaneG9)
* Tiffany Vallo | [GitHub](https://github.com/tiffanyvallo)
* Finn Williamson | [GitHub](https://github.com/fwill22)

<p>&nbsp;</p>

### [| Original project repo |](https://github.com/makersacademy/course/tree/master/makersbnb)