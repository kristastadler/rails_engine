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

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = { name: "Hula Hoop",
                    description: "Spinning fun",
                    unit_price: 15.24,
                    merchant_id: merchant.id }

    post "/api/v1/items", params: {item: item_params}
    item = Item.last
    parse_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.merchant_id).to eq(item_params[:merchant_id])
  #  expect(parse_item["attributes"]["name"]).to eq(item.name)
  end

  it "can update an existing item" do
    id = create(:item, merchant: create(:merchant)).id
    previous_name = Item.last.name
    item_params = { name: "Baseball Bat" }

    put "/api/v1/items/#{id}", params: {item: item_params}
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Baseball Bat")
  end

  it "can destroy an item" do
    item = create(:item, name: "Bad Item", merchant: create(:merchant))
    delete "/api/v1/items/#{item.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(json["data"]["attributes"]["name"]).to eq("Bad Item")
  end
end
