# ElasticLogger

ElasticLogger is a simple and elastic (;)) solusion for sending JSON logs to elasticsearch but not only there. It works based on writers. Each writer is used to send logs to diffrent destination. Gem is released with two writers one for ElasticSearch and one for standard log files. You can also create your own Writer and use it in config file.

## Installation

Add this line to your application's Gemfile:

    gem 'elastic-logger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elastic-logger

## Usage Examples

There is a generator for Rails which will create base intialize and config files.
```bash
bundle exec rails generate elastic_logger
```

```ruby
require 'elastic-logger'

# Configuration
ElasticLogger.configure do |config|
  config.host = '192.168.60.10:9200'
  types_file = 'config/elastic_log_config.yml'
  path = 'log'
  prefix = ''
end
```

### Config file
With this file we create two logs, one which will log to elastic, and one to standard log file.

```yml
sidekiq_monitor:
  writer: 'ElasticLogger::ElkWriter'
  level: 'debug' # log level, one of debug, error, fatal, info, unknown, and warn
  delete:
    type: 'standard' # never if you want to keep that log
    unit: 'days' # One of seconds, minutes, hours, days, weeks, months, or years.
    unit_count: 2 # The number of unit (s). unit_count * unit will be calculated out to the relative number of seconds.
  backup:
    type: 'standard' # infinite if you want to keep that log, never for no backups
    unit: 'days' # One of seconds, minutes, hours, days, weeks, months, or years.
    unit_count: 2 # The number of unit (s). unit_count * unit will be calculated out to the relative number of seconds.
api_requests:
  writer: 'ElasticLogger::DiskWriter'
  level: 'warn'
```
### Usage

`sidekiq_monitor` is a name of log it will be used with `prefix` to build file name or index name in elastic.

```ruby
logger = ElasticLogger::Logger.new('sidekiq_monitor')
logger.log(foo: :bar)
```

### Writers

#### ElastickWriter

Creates daily index named after log name. For sidekiq_monitor it will creates `sidekiq_monitr-%Y.%m.%d` index each day, with `sidekiq_monitor` type and injects there hashes from user input. Next you can go to Kibana and search in it.

#### DiskWriter

It is use by us mostly on devels, when we don't want to use elk for logs. Internally it use ruby `Logger`.

#### Custom Writer

You can create your own writer. It needs two mtethods:
* `initialize` with `name` and `config` named params
* `log` with one params with is hash to log.

### Capistrano

```ruby
# Capfile
require 'elastic-logger/capistrano'
```

Index in elasticsearch will be updated after deploy, with all used elk logs.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
