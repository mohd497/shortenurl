## ShortenUrl
This project will shorten provided urls and also inflate shorten url to its original form

### System dependencies
* Ruby 2.4.2

### Gems 
* rails 5.1.4
* bootstrap-sass
* rspec-rails 3.6

### Setup guide
* install the ruby version 2.4.2
* install rails 5.1.4
* git clone the repo
* cd shortenurl

```console
bundle install
rake db:create db:migrate 
rails s
```
### Deploy
* depoyed on AWS lightsail instance @ http://54.197.23.63:3000/

### Tests

```console
bundle exec rspec
```
### What was done
* make url short
* inflate url (run on browser)
* unit tests

### What is remaining
* make use of more robust database like pg or mysql
