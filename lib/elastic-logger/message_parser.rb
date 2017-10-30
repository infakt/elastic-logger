module ElasticLogger
  class MessageParser
    def call(message)
      case message
      when String then { message: message }
      when Array then message.map.with_index { |v, i| [i, v] }.to_h
      else message
      end
    end
  end
end
