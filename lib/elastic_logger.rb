require 'elastic_logger/disk_writer'
require 'elastic_logger/elk_writer'

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
