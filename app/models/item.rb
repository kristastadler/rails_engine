class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.find_all(params)
    name_query = params[:name]
    require "pry"; binding.pry
    Merchant.where('name LIKE ?', 'name_query').all
  end
end
