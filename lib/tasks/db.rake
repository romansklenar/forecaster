namespace :db do
  
  desc 'Maintains database by running command as ANALYZE, VACUUM and REINDEX'
  task maintain: :environment do
    ActiveRecord::Base.establish_connection(ENV['RAILS_ENV'] || :development)
    ActiveRecord::Base.connection.execute("VACUUM FULL VERBOSE");
    ActiveRecord::Base.connection.execute("ANALYZE VERBOSE");
    ActiveRecord::Base.connection.execute("REINDEX DATABASE #{ActiveRecord::Base.connection.current_database}");
  end

  desc 'Remigrate database and seed data'
  task remigrate: :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
  end

end
