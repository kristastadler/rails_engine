class Api::V1::ItemsController < ApplicationController
  def index
    data = {"data" => Item.all}
    render json: data
  end

  def show
    item = Item.find(params[:id])
    data = {
            "data" => {
              "id" => item.id.to_s,
              "type" => "item",
              "attributes" => {
                "name" => item.name,
                "description" => item.description,
                "unit_price" => item.unit_price.to_f,
                "merchant_id" => item.merchant_id}}}
    render json: data
  end

  def create
    merchant_id = params[:merchant_id].to_i
    unit_price = params[:unit_price].to_f
    # data = {
    #         "data" => {
    #           "id" => item.id.to_s,
    #           "type" => "item",
    #           "attributes" => {
    #             "name" => item.name,
    #             "description" => item.description,
    #             "unit_price" => item.unit_price.to_f,
    #             "merchant_id" => item.merchant_id}}}
    render json: Item.create(name: params[:name],
                      description: params[:description],
                      unit_price: unit_price,
                      merchant_id: merchant_id)
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    data = {
            "data" => {
              "id" => item.id.to_s,
              "type" => "item",
              "attributes" => {
                "name" => item.name,
                "description" => item.description,
                "unit_price" => item.unit_price.to_f,
                "merchant_id" => item.merchant_id}}}
    render json: data
  end

  def destroy
    item = Item.find(params[:id])
    data = {
            "data" => {
              "id" => item.id.to_s,
              "type" => "item",
              "attributes" => {
                "name" => item.name,
                "description" => item.description,
                "unit_price" => item.unit_price.to_f,
                "merchant_id" => item.merchant_id}}}
    render json: data
    Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

end
