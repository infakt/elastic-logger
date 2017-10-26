require 'elastic-logger/types'

module ElasticLogger
  class Logger
    def initialize(name)
      @name = name.to_s
    end

    def log(hash)
      writer.log(hash)
    end
    alias_method :debug, :log
    alias_method :info, :log
    alias_method :warn, :log

    private
    attr_reader :name

    def writer
      writer = logs.fetch(name, default).fetch("writer")
      Object.const_get(writer).new(name: log_name, config: config)
    end

    def log_name
      [config.prefix, name].map(&:to_s).reject(&:empty?).join("_")
    end

    def config
      @config ||= ElasticLogger.configuration
    end

    def logs
      @@logs ||= ElasticLogger::Types.new.all
    end

    def default
      { "writer" => "ElasticLogger::NullLogger" }
    end
  end
end
