after "deploy", "elastic_logger:rotate"

namespace :load do
  task :defaults do
    set :elastic_logger_server_role, -> { :elasticlogger }
  end
end

namespace :elastic_logger do
  desc 'Sends info about rotations to elastic'
  task :rotate do
    on roles fetch(:elastic_logger_server_role) do
      within(current_path) do
        execute :rake, 'elastic_logger:rotate', fetch(:rails_env)
      end
    end
  end
end
