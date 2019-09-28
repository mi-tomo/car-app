Rails.application.routes.draw do
  root  'products#index'  
  # get 'products' => 'products#index'
  # get 'products' => 'products#new' 
  # post 'products' => 'products#create'
  # get 'products' => 'products#edit' 
  # resources :products, only: [:index, :create,  :update,  :edit, :new ,:destroy]
  
  resources :carnames
  resources :orders 
    resources :products
  

  
end
