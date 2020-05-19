class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  # def show
  #   render json: ItemSerializer.new(Item.find(params[:id]))
  # end
  #
  # def create
  #   item = Item.create!(item_params)
  #   render json: ItemSerializer.new(item)
  # end
  #
  # def update
  #   item = Item.find(params[:id])
  #   item.update(item_params)
  #   render json: ItemSerializer.new(item)
  # end
  #
  # def destroy
  #   item = Item.find(params[:id])
  #   render json: ItemSerializer.new(item)
  #   Item.delete(params[:id])
  # end
  #
  # private
  #
  # def merchant_params
  #   params.permit(:name)
  # end

end
