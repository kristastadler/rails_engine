class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  scope :filter_by_name, -> (name) { where "lower(name) LIKE ?", "%#{name}%" }
  scope :filter_by_created_at, -> (created_at) { where created_at: created_at }
  scope :filter_by_updated_at, -> (updated_at) { where updated_at: updated_at }

  def self.find_most_revenue(quantity)
    joins(:invoice_items).group(:id)
                         .order('SUM (invoice_items.quantity * invoice_items.unit_price) DESC')
                         .limit(quantity)
  end

  def self.find_most_items(quantity)
    joins(:invoice_items).group(:id)
                         .order('SUM (invoice_items.quantity) DESC')
                         .limit(quantity)
  end 
end
