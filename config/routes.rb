Rails.application.routes.draw do
  get '/' => 'home#index'  
  post '/home/index' => 'home#create_order'  
end
