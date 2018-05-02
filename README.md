# Edge-Case Bakery

You can check it [here](https://radiant-tundra-38379.herokuapp.com/)

It is a fullstack bakery website that displays information on produce offered for sale as well as enables someone to receive a catalog of items sold via email.

The requirements for completing this project are:

* use the Sendgrid API to send an email to the user’s email with a catalog of all items sold
* API key should be stored in an environment variable
* Technologies Used Ruby, Sinatra, HTML, CSS, JS, Materialize, API

Features The key features are:

* Sengrid API sending email;
* Materialize is used for page styling (card, tabs);

# How to

1. `rake db:create_migration NAME=create_users_table.rb`

1. `rake db:migrate`

1. `rake db:seed`