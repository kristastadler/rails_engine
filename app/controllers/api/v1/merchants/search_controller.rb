class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.query(params)
    render json: MerchantSerializer.new(merchant)
  end
end
