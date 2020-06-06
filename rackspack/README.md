Please follow given step for setup the project

clone the project in your local machine from the github url
- bundle install
- rake db:create
- rake db:migrate

bundle exec figaro install
go to application.yml add 

development:
  BITLY_TOKEN: "token_key"

Now open new terminal tab to run sidekiq

- bundle exec sidekiq

Now load db seed file
- rake db:seed 

Fews record will be created for demo.

First you have to login using email and password
email- admin@exmaple.com
password 123456




