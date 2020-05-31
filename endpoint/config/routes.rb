Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    # Api access to categories resorces
    get 'categories', to: 'categories#index', format: false

    # Api access to jimen resources
    resources :jimen, only: %i[index show update create], format: false

    # Api access to jimen searched by category_id
    get 'jimen/list/:category_id', to: 'jimen#list', format: false

    # Api access to jump detail pages, meaning count-up access counter.
    post 'jimen/jump/:id', to: 'jimen#jump', format: false

    # Api access to reviews searched by jiman_id
    get 'reviews/show/:jiman_id', to: 'reviews#show', format: false
    get 'reviews/list/:jiman_id', to: 'reviews#list', format: false
    post 'reviews/:jiman_id', to: 'reviews#save', format: false
  end
end
