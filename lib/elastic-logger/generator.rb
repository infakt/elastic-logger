require 'rails/generators'

class ElasticLoggerGenerator < Rails::Generators::Base

  self.source_paths << File.join(File.dirname(__FILE__), 'templates')

  def create_config_files
    template 'elastic_log_types.yml', 'config/elastic_log_types.yml.example'
    template 'elastic_logger.rb', 'config/initializers/elastic_logger.rb'
  end
end
