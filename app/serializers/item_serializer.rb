class ItemSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  set_type :item
  attributes :id, :name, :description, :unit_price, :merchant_id
end
