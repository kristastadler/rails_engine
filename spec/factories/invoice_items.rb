FactoryBot.define do
  factory :invoice_item do
    name { "MyString" }
    item_id { "" }
    invoice_id { "" }
    quantity { "" }
    unit_price { "" }
    created_at { "MyText" }
    updated_at { "MyText" }
  end
end
