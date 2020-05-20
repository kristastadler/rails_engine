class Api::V1::Merchants::SearchController < ApplicationController
  def show
    @merchants = Merchant.where(nil)
    filtering_params(params).each do |key, value|
      @merchants = @merchants.public_send("filter_by_#{key}", value) if value.present?
    end
    merchant = @merchants.first
    render json: MerchantSerializer.new(merchant)
  end

  def index
    @merchants = Merchant.where(nil)
    filtering_params(params).each do |key, value|
      @merchants = @merchants.public_send("filter_by_#{key}", value) if value.present?
    end
    render json: MerchantSerializer.new(@merchants)
  end

  def most_items
    @merchants = Merchant.find_most_items(params[:quantity])
    render json: MerchantSerializer.new(@merchants)
  end

  def most_revenue
    @merchants = Merchant.find_most_revenue(params[:quantity])
    render json: MerchantSerializer.new(@merchants)
  end

  def total_revenue
    revenue = Merchant.find_total_revenue(params[:id])
    # @merchant = Merchant.find(params[:id])
    # revenue = @merchant.find_total_revenue
    data = {
            "data" => {
              "id" => "null",
              "attributes" => {
                "revenue"  => revenue
              }
            }
          }
    render json: data

  end

  private

  def filtering_params(params)
    params.slice(:name, :created_at, :updated_at)
  end
end
