class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  set_type :merchant
  attributes :id, :name
end
