class Api::V1::Merchants::SearchController < ApplicationController
  def show
    items = Item.find_all(params)
  end
end
