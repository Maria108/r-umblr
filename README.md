# R-umblr (Ruby Tumblr)

![Admin panel for Marvel school](https://user-images.githubusercontent.com/32076687/41739202-59def7ea-7562-11e8-95c5-e0e7ad6aa376.jpg)

The fourth individual project during Software Engineering Intensive course at New York Code and Design Academy.

It is a fullstack simple blog website that enables someone to sign up for an account and create relevant posts on a topic of their choosing.

The requirements for completing this project are:

* user can create an account/log into and log out of account/delete an account
* show login and signup links only when logged out/show logout links only when logged in
* user can create a new post only when logged in
* have a page that lists out the 20 most recent posts made by the currently logged in user
* have a page that lists the currently logged in user’s profile information
* have the ability to see other user’s last 20 posts
* use Activerecord to make all database transactions
* use Sinatra as the web microframework backend

The key features of this projetc are:

* Activerecord is used to make all database transactions;
* Materialize is used for page styling (card, tabs, floating buttons);
* Sinatra is used as the web microframework backend

Deployed to Heroku: https://veggie-blog.herokuapp.com/

Sample User: email: admin@mail.com password: admin

# How to

1. `bundle install`

1. `rake db:create_migration NAME=create_users_table`

1. `rake db:create_migration NAME=create_posts_table`

1. `rake db:create_migration NAME=create_tags_table`

1. `rake db:create_migration NAME=create_post_tags_table`

1. `rake db:migrate`

1. `rake db:seed`
