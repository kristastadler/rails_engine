require 'rails_helper'

describe "Merchants API" do
  it "finds merchants with matching name attributes" do
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
