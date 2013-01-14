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

  namespace :import do
    desc 'Imports current stock values from Yahoo Finance API for all companies'
    task stocks: :environment do
      require 'csv'
      require 'open-uri'

      codes = Company.pluck(:code).join('+')
      url = "http://finance.yahoo.com/d/quotes.csv?s=#{codes}&f=sd1ohgl1"
      header = [:code, :date, :open, :high, :low, :close]

      Stock.transaction do
        CSV.parse(open(url).read).each do |i|
          row = Hash[[header, i].transpose]
          Stock.where(open: row[:open], high: row[:high], low: row[:low], close: row[:close]).
                where(date: Date.strptime(row[:date], '%m/%d/%Y')).
                where(company: Company.find_by(code: row[:code])).
                first_or_create!
        end
      end
    end
  end # namespace :import

end # namespace :db
