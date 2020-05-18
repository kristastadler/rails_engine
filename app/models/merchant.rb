class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

  def self.query(params)
    Merchant.where("lower(name) like ?", "%#{params[:name]}%").limit(1).reduce  
  end
end
