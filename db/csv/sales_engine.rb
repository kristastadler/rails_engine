require 'csv'
require 'open-uri'

class SalesEngine
  class << self
    def csv_hash
      @csv_hash ||= csv_paths.inject({}) do |new_hash, (file_name, url)|
                      csv_txt = open(url)
                      new_hash[file_name] = CSV.parse(csv_txt, headers: true, header_converters: :symbol)
                      new_hash
                    end
    end

    private

    def csv_paths
      {
        customers: "/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/customers.csv",
        invoice_items: "/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/invoice_items.csv",
        invoices: "/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/invoices.csv",
        items: "/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/items.csv",
        merchants: "/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/merchants.csv",
        transactions: "/Users/kristastadler/turing/3module/projects/rails_engine/db/csv/transactions.csv"
      }
    end

    # def csv_urls
    #   {
    #     customers: base_url("customers"),
    #     invoice_items: base_url("invoice_items"),
    #     invoices: base_url("invoices"),
    #     items: base_url("items"),
    #     merchants: base_url("merchants"),
    #     transactions: base_url("transactions")
    #   }
    # end

    # def base_url(file_name)
    #   "https://raw.githubusercontent.com/turingschool-examples/sales_engine/master/data/#{file_name}.csv"
    # end
  end
end
