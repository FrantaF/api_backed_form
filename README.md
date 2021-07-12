# README


Prequisites: VM with a setup environment including Ruby, Rails and PostgreSQL.

General outline of the work: 

Create app with: rails new api_backed_form --database=postgresql

Add libraries that will be used such as HTTPArty and Figaro. Install these: Bundle i, rails db:create, rails db:migrate, rails s

Link bootstrap in application.html

Create home controller with an index view template: rails g controller Home index

configure routes:
- Default route should point to home#index. 
- We will handle form submission in home#create_order

In views/home/index.html create the form. The structure of the form needs to take into consideration the required fields specified in the API docs. 
In the same directory create a redirect page after the form has been submitted. 

Configure API variables in application.yml 

In home#create_order check for consent permissions -> NOTE: This doesn't see mto work. The sample value provided in the API docs doesn't enable order submission and no consents are retrieved with my credentials. 

After consents have been obtained, send post request to create order using the user-provided values. 

Deploy to Heroku and configure API credentials in the environment

With more time I would start with the following improvements:
- further test the API as I wasn't able to obtain consent IDs.
- spend more time on validation of user data on the back end.
- create a more intuitive customer form also validating for the postcode pattern. 
- general UI improvements.


