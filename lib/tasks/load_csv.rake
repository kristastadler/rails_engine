require './db/csv/sales_engine.rb'
require './db/csv/model_generator.rb'

namespace :db do
  namespace :seed do
    desc "Seeds the db from remote CSV files"
    task :from_csv => :environment do
      ModelGenerator.destroy_models
      csv_hash = SalesEngine.csv_hash
      ModelGenerator.create_models(csv_hash)
    end
  end
end
