Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'shorten_urls#show'
  post '/create_url' => 'shorten_urls#create'
  get '/:url' => 'shorten_urls#fetch_page'
end
