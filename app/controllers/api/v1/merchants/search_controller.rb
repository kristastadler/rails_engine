class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = matches.first
    render json: MerchantSerializer.new(merchant)
  end

  private

  def matches
    search_params.to_h.inject([]) do |merchants, (attr, value)|
      merchants << Merchant.where("lower(#{attr}) LIKE ?", "%#{value}")
      merchants.flatten
    end
  end

  def search_params
    params.permit(:name, :created_at, :updated_at)
  end
end
