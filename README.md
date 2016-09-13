# SugoiHttpTesterRails
## Requirements
* Job Queue System
  * example for
    * DelayedJob
* sugoi_http_request_tester gem

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'sugoi_http_tester_rails', github: 'jiikko/sugoi_http_tester_rails'
```

have to create first record of project.

```
echo 'SugoiHttpTesterRails::Project.all.create!(name: :test_project)' | rails console
```

### Delayedjob
```
rails generate delayed_job:active_record
rake db:migrate
```

## Usage
### in config/routes.rb
```ruby
Rails.application.routes.draw do
  mount SugoiHttpTesterRails::Engine => "/http_tester"
end
```

## Development
```
cd spec/dummy
bundle exec rake jobs:work
```

## Test
```shell
cd spec/dummy
bundle exec rspec
```
