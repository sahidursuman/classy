require "csv"

namespace :db do
  task recreate: :environment do
    if Rails.env.development?
      list_task = %w[db:drop db:create db:migrate db:master_data:create_data db:seed]
      list_task.each do |task|
        puts "\e[36mEXECUTE #{task} COMMAND\e[0m"
        Rake::Task[task].invoke
      end
    else
      puts "\e[31mdb:recreate task can be executed only in the development environment.\e[0m"
    end
  end

  namespace :master_data do
    task create_data: :environment do
      ActiveRecord::Base.transaction do
        [:cities, :districts, :training_types, :categories].each do |model|
          puts "Creating master data for #{model}"
          klass = model.to_s.classify.safe_constantize
          CSV.open("#{Rails.root}/db/csv/#{klass.to_s.underscore.pluralize}.csv",
            {headers: true, header_converters: :downcase}).each do |row|
            klass.create! row.to_hash
          end
        end
      end
    end
  end
end
