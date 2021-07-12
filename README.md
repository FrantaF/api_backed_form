# README


Prequisites: VM with a configured environment including Ruby, Rails and PostgreSQL.

General outline of the work: 

Create the layout of a new app using Ruby & Rails: rails new api_backed_form --database=postgresql

Add libraries that will be used throughout the project such as HTTPArty and Figaro and initiate the applicaiton: bundle exec figaro install, bundle i, rails db:create, rails db:migrate, rails s

Add links to bootstrap in application.html.erb so we can use bootstrap css classes for a general layout.

Create home controller with an index view template which will be used for the form: rails g controller Home index. 

Configure routes:
- Default route should point to our form under home#index. 
- Submission of the form will be handled in home#create_order

Next create a rails form in views/home/index.html.erb. The structure of the form needs to take into consideration the required fields specified in the API docs. 
In the same directory we also create a page where we will be redirected to after the form has been submitted.

Before we start interacting with the API, we configure API variables in application.yml so that the credentials don't become accidentally exposed later. 

Interaction with the API will be done in the home#create_order controller method. We first check for consent permissions.
NOTE: This part didn't work for me. Using the provided credentials led to a successful interaction with the API but no consents were retrieved. Submitting the order using the sample consent_id from the dicumentation also didn't work.

After sourcing the constent_ids we create body of the submit_prder request using the user provided parameters with params[order].

We can now deploy the application to Github and Heroku and configure the API credentials in Heroku with bundle exec figaro heroku:set -e production


With more time I would further focus on the following points:
- further test the API as I wasn't able to obtain consent IDs.
- spend more time on validation of user data on the back end.
- create a more intuitive customer form also validating for the postcode pattern. 
- general UI improvements.

Thank you.

