class Api::V1::MerchantItemsController < ApplicationController
  def show
    item = Item.find(params[:item_id])
    merchant = Merchant.find(item.merchant_id)
    data = {
          "data": {
                  "type" => "merchant",
                  "attributes" => {
                  "id" => merchant.id,
                  "name" => merchant.name
              }
            }
          }
    render json: data
  end

  def index
    merchant = Merchant.find(params[:merchant_id])
    data = {"data" => merchant.items}
    render json: data
  end
end
