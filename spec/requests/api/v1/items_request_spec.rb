require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 4, merchant: create(:merchant))

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(4)
  end

  it "can get one item by its id" do
    create(:item, name: "Silly Name", merchant: create(:merchant))
    id = Item.last.id
    name = Item.last.name

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(id.to_s)
  end
end
