module ElasticLogger
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'elastic-logger/rotate.rake'
    end

    generators do
      require 'elastic-logger/generator'
    end
  end
end
