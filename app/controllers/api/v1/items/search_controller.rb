class Api::V1::Items::SearchController < ApplicationController
  def show
    item = matches.first
    render json: ItemSerializer.new(item)
  end

  private

  def matches
    search_params.to_h.inject([]) do |items, (attr, value)|
      items << Item.where("lower(#{attr}) LIKE ?", "%#{value}%")
      items.flatten
    end
  end

  def search_params
    params.permit(:name, :description, :created_at, :updated_at, :unit_price, :merchant_id)
  end
end
