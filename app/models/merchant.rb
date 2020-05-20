class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  scope :filter_by_name, -> (name) { where "lower(name) LIKE ?", "%#{name}%" }
  scope :filter_by_created_at, -> (created_at) { where created_at: created_at }
  scope :filter_by_updated_at, -> (updated_at) { where updated_at: updated_at }

  def self.find_most_revenue(quantity)
    Merchant.joins(:transactions, :invoice_items)
            .where(transactions: { result: :success })
            .group(:id)
            .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
            .order('revenue DESC')
            .limit(quantity)
  end

  def self.find_most_items(quantity)
    Merchant.joins(:transactions, :invoice_items)
            .where(transactions: { result: :success })
            .group(:id)
            .select("merchants.*, sum(invoice_items.quantity) as count")
            .order('count DESC')
            .limit(quantity)
  end

  def self.find_total_revenue(id)
    merchant = Merchant.joins(:transactions, :invoice_items)
              .where(transactions: { result: :success })
              .where(invoices: { merchant_id: id })
              .group(:id)
              .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    merchant.reduce.revenue.to_f
  end
end
