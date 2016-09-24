# SugoiHttpTesterRails
This gem is rails engine for sugoi_http_request_tester.

## Requirements
* gems
  * delayed_job
  * sugoi_http_request_tester
  * kaminari
  * slim-rails

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'sugoi_http_tester_rails', github: 'jiikko/sugoi_http_tester_rails'
```
### Delayedjob
```
rails generate delayed_job:active_record
rake db:migrate
```

### migration
```
$ bundle exec rake sugoi_http_tester_rails:install:migrations
$ bundle exec rake db:migrate
```

## Usage
Add this line to your config/routes.rb

```ruby
Rails.application.routes.draw do
  mount SugoiHttpTesterRails::Engine => "/http_tester"
end
```

## Development
```
bundle exec rake db:migrate
cd spec/dummy
bundle exec rake jobs:work
```

## Test
```shell
cd spec/dummy
bundle exec rspec
```
