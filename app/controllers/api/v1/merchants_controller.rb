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

  def destroy
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
    Merchant.delete(params[:id])
  end

  private

  def merchant_params
    params.permit(:name)
  end

end
