Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    # Api access to categories resorces
    get 'categories', to: 'categories#index', format: false

    # Api access to jimen resources
    resources :jimen, only: %i[index show], format: false

    # Api access to games searched by category id
    get 'jimen/list/:category_id', to: 'jimen#list', format: false
  end
end
