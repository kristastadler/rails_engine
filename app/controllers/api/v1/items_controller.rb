class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item)
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
    Item.delete(params[:id])
  end

  private

  def create_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

end
