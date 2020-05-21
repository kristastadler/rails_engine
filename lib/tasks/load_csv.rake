require './db/csv/seed_starter.rb'

namespace :db do
  namespace :seed do
    desc "Uses remote CSV files to seed the database"
    task :from_csv => :environment do
      SeedStarter.destroy_models
      puts 'Cleared Existing Models'

      SeedStarter.create_customers
      puts 'Created Customers'

      SeedStarter.create_merchants
      puts 'Created Merchants'

      SeedStarter.create_items
      puts 'Created Items'

      SeedStarter.create_invoices
      puts 'Created Invoices'

      SeedStarter.create_invoice_items
      puts 'Created Invoice Items'

      SeedStarter.create_transactions
      puts 'Created Transactions'

      ActiveRecord::Base.connection.tables.each do |t|
        ActiveRecord::Base.connection.reset_pk_sequence!(t)
      end
      puts 'Reset Primary Key Sequence'
      puts 'Database Seeded!'

    end
  end
end
