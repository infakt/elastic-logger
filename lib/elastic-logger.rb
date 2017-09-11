require 'elastic-logger/configuration'
require 'elastic-logger/logger'

require 'elastic-logger/disk_writer'
require 'elastic-logger/elk_writer'
require 'elastic-logger/elk_rotator'

require 'elastic-logger/railtie' if defined?(Rails)

module ElasticLogger
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
