require 'elastic-logger/message_parser'
require 'elastic-logger/types'

module ElasticLogger
  class Logger

    def initialize(name, log_level = nil)
      @name = name.to_s
      @log_level = log_level
    end

    # def debug(hash)
    # def error(hash)
    # def fatal(hash)
    # def info(hash)
    # def unknown(hash)
    # def warn(hash)
    %w(debug error fatal info unknown warn).each do |severity|
      define_method(severity) do |hash|
        log(hash, severity)
      end
    end

    def log(msg, severity = 'unknown')
      return true if skip_logging?(severity)

      writer.log(severity, format_message(msg))
      true
    end

    def level=(level)
      @log_level = level
    end

    private
    attr_reader :name

    def skip_logging?(severity)
      log_levels[severity] < log_levels[log_level]
    end

    def writer
      Object.const_get(log_writer).new(name: log_name, config: config)
    end

    def log_name
      [config.prefix, name].map(&:to_s).reject(&:empty?).join("_")
    end

    def config
      @config ||= ::ElasticLogger.configuration
    end

    def format_message(msg)
      ::ElasticLogger::MessageParser.new.(msg)
    end

    def log_writer
      log_type.fetch('writer')
    end

    def log_level
      @log_level ||= log_type.fetch('level', 'info')
    end

    def log_type
      @log_type ||= ::ElasticLogger::Types.new.find(name)
    end

    def log_levels
      @log_levels ||= Hash.new do |hash, key|
        hash[key] = ::Logger.const_get(key.to_s.upcase)
      end
    end
  end
end
