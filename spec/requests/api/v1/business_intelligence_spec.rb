require 'rails_helper'

describe "Merchants API" do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Joe's Baseball Shop")
    @merchant_2 = create(:merchant, name: "Pete's Pretty Things")
    @merchant_3 = create(:merchant, name: "James' Toy Shop")
    @merchant_4 = create(:merchant, name: "Ben's Boat Shop")

    customer_1 = Customer.create(first_name: "Joe", last_name: "Smith")
    id_1 = create(:item, merchant: @merchant_1).id
    id_2 = create(:item, merchant: @merchant_2).id
    id_3 = create(:item, merchant: @merchant_3).id
    id_4 = create(:item, merchant: @merchant_4).id

    invoice_1 = Invoice.create(merchant_id: @merchant_1.id, customer_id: customer_1.id)
    invoice_2 = Invoice.create(merchant_id: @merchant_1.id, customer_id: customer_1.id)
    invoice_3 = Invoice.create(merchant_id: @merchant_1.id, customer_id: customer_1.id)
    invoice_4 = Invoice.create(merchant_id: @merchant_2.id, customer_id: customer_1.id)
    invoice_5 = Invoice.create(merchant_id: @merchant_2.id, customer_id: customer_1.id)
    invoice_6 = Invoice.create(merchant_id: @merchant_3.id, customer_id: customer_1.id)
    invoice_7 = Invoice.create(merchant_id: @merchant_4.id, customer_id: customer_1.id)
    invoice_8 = Invoice.create(merchant_id: @merchant_4.id, customer_id: customer_1.id)

    invoice_item_1 = invoice_1.invoice_items.create(item_id: id_1, quantity: 4, unit_price: 5.0) # $20 value
    invoice_item_2 = invoice_1.invoice_items.create(item_id: id_1, quantity: 2, unit_price: 6.0) # $12
    invoice_item_3 = invoice_1.invoice_items.create(item_id: id_1, quantity: 1, unit_price: 2.5) # 2.5
    invoice_item_1 = invoice_2.invoice_items.create(item_id: id_1, quantity: 2, unit_price: 50.0) # $100
    invoice_item_1 = invoice_2.invoice_items.create(item_id: id_1, quantity: 2, unit_price: 10.0) # $20
    invoice_item_1 = invoice_3.invoice_items.create(item_id: id_1, quantity: 1, unit_price: 17.0) #17
    invoice_item_1 = invoice_4.invoice_items.create(item_id: id_2, quantity: 2, unit_price: 15.0) #30
    invoice_item_1 = invoice_4.invoice_items.create(item_id: id_2, quantity: 1, unit_price: 100.0) #100
    invoice_item_1 = invoice_5.invoice_items.create(item_id: id_2, quantity: 5, unit_price: 20.0) #100
    invoice_item_1 = invoice_6.invoice_items.create(item_id: id_3, quantity: 7, unit_price: 4.0) #28
    invoice_item_1 = invoice_7.invoice_items.create(item_id: id_4, quantity: 8, unit_price: 10.0) #80
    invoice_item_2 = invoice_7.invoice_items.create(item_id: id_4, quantity: 2, unit_price: 60.0) #120
    invoice_item_3 = invoice_8.invoice_items.create(item_id: id_4, quantity: 2, unit_price: 60.0)

    transaction_1 = invoice_1.transactions.create(result: "success")
    transaction_2 = invoice_2.transactions.create(result: "success")
    transaction_3 = invoice_3.transactions.create(result: "success")
    transaction_4 = invoice_4.transactions.create(result: "success")
    transaction_5 = invoice_5.transactions.create(result: "success")
    transaction_6 = invoice_6.transactions.create(result: "success")
    transaction_7 = invoice_7.transactions.create(result: "success")
    

  end
  it "returns a variable number of merchants ranked by total revenue" do

    get '/api/v1/merchants/most_revenue?quantity=3'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    first_merchant = merchants["data"].first
    last_merchant = merchants["data"].last
    expect(merchants["data"].count).to eq(3)
  end

  it "returns a variable number of merchants ranked by total number of items sold" do

    get '/api/v1/merchants/most_items?quantity=2'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    first_merchant = merchants["data"].first
    last_merchant = merchants["data"].last

    expect(merchants["data"].count).to eq(2)
  end

  it "returns total revenue for a single merchant" do
    get "/api/v1/merchants/#{@merchant_2.id}/revenue"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["revenue"]).to eq(230)

    get "/api/v1/merchants/#{@merchant_3.id}/revenue"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["revenue"]).to eq(28.0)
  end
end
