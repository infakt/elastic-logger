require 'elastic-logger/types'

module ElasticLogger
  class Logger

    def initialize(name)
      @name = name.to_s
    end

    # def debug(hash)
    # def error(hash)
    # def fatal(hash)
    # def info(hash)
    # def unknown(hash)
    # def warn(hash)
    %w(debug error fatal info unknown warn).each do |severity|
      define_method(severity) do |hash|
        log(hash, severity.to_s.upcase)
      end
    end

    def log(msg, severity = 'UNKNOWN')
      return true if ::Logger.const_get(severity) < config.log_level

      writer.log(severity, format(msg))
      true
    end

    private
    attr_reader :name

    def writer
      writer = logs.fetch(name, default).fetch("writer")
      Object.const_get(writer).new(name: log_name, config: config)
    end

    def format(msg)
      case msg
      when String then { msg: msg }
      when Array then msg.map.with_index { |v, i| [i, v] }.to_h
      else msg
      end
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
