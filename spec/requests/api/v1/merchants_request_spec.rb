require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 4)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(4)
  end

  it "can get one merchant by its id" do
    create(:merchant, name: "Bob Evans")
    id = Merchant.last.id
    name = Merchant.last.name

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end

  it "can create a new merchant" do
    post "/api/v1/merchants", params: { name: "Johnny Appleseed" }
    merchant = Merchant.last
    parse_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant.name).to eq("Johnny Appleseed")
    expect(parse_merchant["data"]["attributes"]["name"]).to eq(merchant.name)
  end

  it "can update an existing merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name

    put "/api/v1/merchants/#{id}", params: {name: "Better Merchant"}
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("Better Merchant")
  end

  it "can destroy a merchant" do
    merchant = create(:merchant, name: "Bad Merchant")
    delete "/api/v1/merchants/#{merchant.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(json["data"]["attributes"]["name"]).to eq("Bad Merchant")
  end
end
