class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

   def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    merchant = Merchant.create!(merchant_params)
    render json: MerchantSerializer.new(merchant)
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    render json: MerchantSerializer.new(merchant)
  end

  # def destroy
  #   item = Item.find(params[:id])
  #   render json: ItemSerializer.new(item)
  #   Item.delete(params[:id])
  # end

  private

  def merchant_params
    params.permit(:name)
  end

end
