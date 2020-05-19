class Api::V1::Items::SearchController < ApplicationController
  def show
    @items = Item.where(nil)
    filtering_params(params).each do |key, value|
      @items = @items.public_send("filter_by_#{key}", value) if value.present?
    end
    item = @items.first
    render json: ItemSerializer.new(item)
  end

  private

  def filtering_params(params)
    params.slice(:name, :description, :created_at, :updated_at, :unit_price, :merchant_id)
  end

end
