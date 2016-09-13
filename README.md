# SugoiHttpTesterRails
## Requirements
* Job Queue System
  * example for
    * DelayedJob
* sugoi_http_request_tester gem

## Installation
have to create first record of project.

```
echo 'SugoiHttpTesterRails::Project.all.create!(name: :test_project)' | rails console
```

### Delayedjob
```
rails generate delayed_job:active_record
rake db:migrate
```

## Test
```shell
cd spec/dummy
bundle exec rspec
```
