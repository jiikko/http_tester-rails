# SugoiHttpTesterRails
## Requirements
* Job Queue System
  * example for
    * delayed_job
* gem sugoi_http_request_tester
* gem kaminari
* gem slim-rails

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

### migration files
```
$ bundle exec rake sugoi_http_tester_rails:install:migrations
Copied migration 20160924020059_create_http_tester_projects.sugoi_http_tester_rails.rb from sugoi_http_tester_rails
Copied migration 20160924020060_create_http_tester_template_requests.sugoi_http_tester_rails.rb from sugoi_http_tester_rails
Copied migration 20160924020061_create_http_tester_template_request_groups.sugoi_http_tester_rails.rb from sugoi_http_tester_rails
Copied migration 20160924020062_create_http_tester_testing_hosts.sugoi_http_tester_rails.rb from sugoi_http_tester_rails
Copied migration 20160924020063_create_http_tester_requests.sugoi_http_tester_rails.rb from sugoi_http_tester_rails
Copied migration 20160924020064_create_http_tester_testing_jobs.sugoi_http_tester_rails.rb from sugoi_http_tester_rails
Copied migration 20160924020065_create_http_tester_rails_host_basic_auths.sugoi_http_tester_rails.rb from sugoi_http_tester_rails
```

## Usage
### in config/routes.rb
```ruby
Rails.application.routes.draw do
  mount SugoiHttpTesterRails::Engine => "/http_tester"
end
```

### in config/initializers/filter_parameter_logging.rb
```
Rails.application.config.filter_parameters += [
  :password,
  :basic_auth_username, # add
  :basic_auth_password, # add
]
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
