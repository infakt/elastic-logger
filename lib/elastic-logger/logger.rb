require 'elastic-logger/types'

module ElasticLogger
  class Logger

    def initialize(name, log_level = 'debug')
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

      writer.log(format_severity(severity), format_message(msg))
      true
    end

    private
    attr_reader :name, :log_level

    def skip_logging?(severity)
      log_levels[severity] < log_levels[log_level]
    end

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

    def log_levels
      @log_levels ||= Hash.new do |hash, key|
        hash[key] = ::Logger.const_get(format_severity(severity))
      end
    end

    def format_severity(severity)
      severity.to_s.upcase
    end

    def format_message(msg)
      case msg
      when String then { msg: msg }
      when Array then msg.map.with_index { |v, i| [i, v] }.to_h
      else msg
      end
    end
  end
end
