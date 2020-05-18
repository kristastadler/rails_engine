Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :items, except: [:new, :edit]
      get "items/:item_id/merchant", to: "merchant_items#show"
      get "merchants/:merchant_id/items", to: "merchant_items#index"

      namespace :merchants do
        get "find", to: "search#show"
      end
    end
  end

end
