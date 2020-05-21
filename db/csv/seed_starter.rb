require 'csv'

class SeedStarter
  class << self
    def destroy_models
      Customer.destroy_all
      Merchant.destroy_all
      Item.destroy_all
      Invoice.destroy_all
      InvoiceItem.destroy_all
      Transaction.destroy_all
    end

    def create_customers
      customers = CSV.foreach("/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/customers.csv", headers: true, header_converters: :symbol)
          customers.each do |row|
            Customer.create({
              id: row[:id],
              first_name: row[:first_name],
              last_name: row[:last_name],
              created_at: row[:created_at],
              updated_at: row[:updated_at]})
      end
    end

    def create_merchants
      merchants = CSV.foreach("/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/merchants.csv", headers: true, header_converters: :symbol)
        merchants.each do |row|
          Merchant.create({
              id: row[:id],
              name: row[:name],
              created_at: row[:created_at],
              updated_at: row[:updated_at]})
      end
    end

    def create_items
      items = CSV.foreach("/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/items.csv", headers: true, header_converters: :symbol)
        items.each do |row|
          Item.create({
              id: row[:id],
              name: row[:name],
              description: row[:description],
              unit_price: row[:unit_price].to_f/100,
              merchant_id: row[:merchant_id],
              created_at: row[:created_at],
              updated_at: row[:updated_at]})
      end
    end

    def create_invoices
      invoices = CSV.foreach("/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/invoices.csv", headers: true, header_converters: :symbol)
        invoices.each do |row|
          Invoice.create({
            id: row[:id],
            customer_id: row[:customer_id],
            merchant_id: row[:merchant_id],
            status: row[:status],
            created_at: row[:created_at],
            updated_at: row[:updated_at]})
      end
    end

    def create_invoice_items
      invoice_items = CSV.foreach("/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/invoice_items.csv", headers: true, header_converters: :symbol)
        invoice_items.each do |row|
          InvoiceItem.create({
            id: row[:id],
            item_id: row[:item_id],
            invoice_id: row[:invoice_id],
            unit_price: row[:unit_price].to_f/100,
            quantity: row[:quantity],
            created_at: row[:created_at],
            updated_at: row[:updated_at]})
        end
    end

    def create_transactions
      transactions = CSV.foreach("/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/transactions.csv", headers: true, header_converters: :symbol)
        transactions.each do |row|
          Transaction.create({
            id: row[:id],
            invoice_id: row[:invoice_id],
            credit_card_number: row[:credit_card_number],
            credit_card_expiration_date: row[:credit_card_expiration_date],
            result: row[:result],
            created_at: row[:created_at],
            updated_at: row[:updated_at]})
      end
    end
  end
end
