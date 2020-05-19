require 'rails_helper'

describe "Items API" do
  it "finds all items with a matching attribute" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, name: "Baseball Bat", description: "Hit lots of things", unit_price: 15.25, merchant: merchant_1 )
    item_2 = create(:item, name: "Batmobile", description: "Run into buildings", unit_price: 10.00, merchant: create(:merchant) )
    item_3 = create(:item, name: "Catwoman", description: "Hit bad guys", unit_price: 17.15, merchant: merchant_1 )
    item_4 = create(:item, name: "Penguin", description: "Waddle around", unit_price: 8.00, merchant: create(:merchant))

    get '/api/v1/items/find_all?name=bat'
    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(2)
  end

  it "finds all items with matching description" do
    merchant_1 = create(:merchant)
    item_2 = create(:item, name: "Batmobile", description: "Run into buildings", unit_price: 10.00, merchant: create(:merchant) )
    item_1 = create(:item, name: "Baseball Bat", description: "Hit lots of things", unit_price: 15.25, merchant: merchant_1 )
    item_3 = create(:item, name: "Catwoman", description: "Hit bad guys", unit_price: 17.15, merchant: merchant_1 )
    item_4 = create(:item, name: "Penguin", description: "Waddle around when you hit the ground", unit_price: 8.00, merchant: create(:merchant))

    get '/api/v1/items/find_all?description=hit'
    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end

  it "finds all items with matching merchant id" do
    merchant_1 = create(:merchant)
    id = merchant_1.id
    item_2 = create(:item, name: "Batmobile", description: "Run into buildings", unit_price: 10.00, merchant: create(:merchant) )
    item_1 = create(:item, name: "Baseball Bat", description: "Hit lots of things", unit_price: 15.25, merchant: merchant_1 )
    item_3 = create(:item, name: "Catwoman", description: "Hit bad guys", unit_price: 17.15, merchant: merchant_1 )
    item_4 = create(:item, name: "Penguin", description: "Waddle around", unit_price: 8.00, merchant: create(:merchant))

    get "/api/v1/items/find_all?merchant_id=#{id}"
    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(2)
  end

  it "finds all items matching multiple attributes" do
    merchant_1 = create(:merchant)
    item_2 = create(:item, name: "Batmobile", description: "Run into buildings", unit_price: 10.00, merchant: create(:merchant) )
    item_1 = create(:item, name: "Baseball Bat", description: "Run around and hit lots of things", unit_price: 15.25, merchant: merchant_1 )
    item_3 = create(:item, name: "Catwoman", description: "Hit bad guys", unit_price: 17.15, merchant: merchant_1 )
    item_4 = create(:item, name: "Penguin", description: "Waddle around", unit_price: 8.00, merchant: create(:merchant))

    get '/api/v1/items/find_all?name=bat&description=run'

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(2)
  end
end

describe "Merchants API" do
  it "finds all merchant with matching name attributes" do
    merchant_1 = create(:merchant, name: "The Goldsmith")
    merchant_2 = create(:merchant, name: "Piano Man")
    merchant_3 = create(:merchant, name: "Smith Brothers")
    merchant_4 = create(:merchant, name: "Pro Golf")

    get '/api/v1/merchants/find_all?name=smith'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(2)
  end
end
