class ItemSerializer
  include FastJsonapi::ObjectSerializer
  set_type :item
  attributes :name, :description, :unit_price, :merchant_id

  attribute :unit_price do |price|
    price.unit_price.to_f
  end
end
