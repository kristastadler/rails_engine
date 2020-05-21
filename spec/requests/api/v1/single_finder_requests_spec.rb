require 'rails_helper'

describe "Merchants API" do
  it "finds a merchant with matching name attributes" do
    merchant_1 = create(:merchant, name: "The Goldsmith")
    merchant_2 = create(:merchant, name: "Piano Man")
    merchant_3 = create(:merchant, name: "Smith Brothers")
    merchant_4 = create(:merchant, name: "Pro Golf")

    get '/api/v1/merchants/find?name=smith'

    expect(response).to be_successful

    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["name"]).to include("smith")
  end
end

describe "Items API" do
  it "finds an item with a matching attribute" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, name: "Baseball Bat", description: "Hit lots of things", unit_price: 15.25, merchant: merchant_1 )
    item_2 = create(:item, name: "Batmobile", description: "Run into buildings", unit_price: 10.00, merchant: create(:merchant) )
    item_3 = create(:item, name: "Catwoman", description: "Hit bad guys", unit_price: 17.15, merchant: merchant_1 )
    item_4 = create(:item, name: "Penguin", description: "Waddle around", unit_price: 8.00, merchant: create(:merchant))

    get '/api/v1/items/find?name=bAT'
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"].downcase).to include("bat")
  end

  it "finds an item with matching description" do
    merchant_1 = create(:merchant)
    item_2 = create(:item, name: "Batmobile", description: "Run into buildings", unit_price: 10.00, merchant: create(:merchant) )
    item_1 = create(:item, name: "Baseball Bat", description: "Hit lots of things", unit_price: 15.25, merchant: merchant_1 )
    item_3 = create(:item, name: "Catwoman", description: "Hit bad guys", unit_price: 17.15, merchant: merchant_1 )
    item_4 = create(:item, name: "Penguin", description: "Waddle around", unit_price: 8.00, merchant: create(:merchant))

    get '/api/v1/items/find?description=RUN'
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq("Batmobile")
    expect(item["data"]["attributes"]["description"]).to eq("Run into buildings")
  end

  it "finds an item with matching merchant id" do
    merchant_1 = create(:merchant)
    id = merchant_1.id
    item_2 = create(:item, name: "Batmobile", description: "Run into buildings", unit_price: 10.00, merchant: create(:merchant) )
    item_1 = create(:item, name: "Baseball Bat", description: "Hit lots of things", unit_price: 15.25, merchant: merchant_1 )
    item_3 = create(:item, name: "Catwoman", description: "Hit bad guys", unit_price: 17.15, merchant: merchant_1 )
    item_4 = create(:item, name: "Penguin", description: "Waddle around", unit_price: 8.00, merchant: create(:merchant))

    get "/api/v1/items/find?merchant_id=#{id}"
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["merchant_id"].to_s).to eq("#{id}")
  end

  it "finds an item with matching unit_price" do
    merchant_1 = create(:merchant)
    id = merchant_1.id
    item_2 = create(:item, name: "Batmobile", description: "Run into buildings", unit_price: 10.00, merchant: create(:merchant) )
    item_1 = create(:item, name: "Baseball Bat", description: "Hit lots of things", unit_price: 15.25, merchant: merchant_1 )
    item_3 = create(:item, name: "Catwoman", description: "Hit bad guys", unit_price: 17.15, merchant: merchant_1 )
    item_4 = create(:item, name: "Penguin", description: "Waddle around", unit_price: 8.00, merchant: create(:merchant))

    get "/api/v1/items/find?unit_price=17.15"
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"].to_s).to eq("Catwoman")
  end

  it "finds an item matching multiple attributes" do
    merchant_1 = create(:merchant)
    item_2 = create(:item, name: "Batmobile", description: "Run into buildings", unit_price: 10.00, merchant: create(:merchant) )
    item_1 = create(:item, name: "Baseball Bat", description: "Hit lots of things", unit_price: 15.25, merchant: merchant_1 )
    item_3 = create(:item, name: "Catwoman", description: "Hit bad guys", unit_price: 17.15, merchant: merchant_1 )
    item_4 = create(:item, name: "Penguin", description: "Waddle around", unit_price: 8.00, merchant: create(:merchant))

    get '/api/v1/items/find?name=bat&description=hit'

    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq("Baseball Bat")
    expect(item["data"]["attributes"]["description"]).to eq("Hit lots of things")
  end
end
