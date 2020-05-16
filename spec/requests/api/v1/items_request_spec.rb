require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 4, merchant: create(:merchant))

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(4)
  end
end
