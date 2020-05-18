class Api::V1::MerchantItemsController < ApplicationController
  def show
    item = Item.find(params[:item_id])
    merchant = Merchant.find(item.merchant_id)
    render json: MerchantSerializer.new(merchant)
  end

  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: ItemSerializer.new(merchant.items)
  end
end
