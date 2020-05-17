class Api::V1::ItemsController < ApplicationController
  def index
    data = {"data" => Item.all}
    render json: data
  end

  def show
    item = Item.find(params[:id])
    data = {"data" => {"id" => item.id.to_s,
                      "attributes" =>
                      {"name" => item.name,
                      "description" => item.description,
                      "unit_price" => item.unit_price.to_f,
                      "created_at" => item.created_at,
                      "updated_at" => item.updated_at,
                      "merchant_id" => item.merchant_id}}}

    render json: data
  end
end
