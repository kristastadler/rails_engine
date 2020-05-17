require 'rails_helper'

describe "Items API" do
  it 'sends a list of items associated with a merchant' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["name"]).to eq(merchant.name)
    expect(json["data"]["attributes"]["id"]).to eq(merchant.id)
  end
end

describe "Merchants API" do
  it 'sends a list of a merchants items' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    