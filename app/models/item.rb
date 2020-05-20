class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  scope :filter_by_name, -> (name) { where "lower(name) LIKE ?", "%#{name}%" }
  scope :filter_by_description, -> (description) { where "lower(description) LIKE ?", "%#{description}%" }
  scope :filter_by_created_at, -> (created_at) { where created_at: created_at }
  scope :filter_by_updated_at, -> (updated_at) { where updated_at: updated_at }
  scope :filter_by_unit_price, -> (unit_price) { where unit_price: unit_price }
  scope :filter_by_merchant_id, -> (merchant_id) { where merchant_id: merchant_id }

  # def self.find_revenue(dates)
  #   start_date = dates[:start].to_date
  #   end_date = dates[:start].to_date
  #   require "pry"; binding.pry
  # end

end
