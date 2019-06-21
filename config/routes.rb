Rails.application.routes.draw do
  # This is essentially get({'/hello_world' => 'application#hello_world'})
  # It is calling the get function and passing a hash as the parameter
  get '/hello_world' => 'application#hello_world'

  get '/list_posts' => 'application#list_posts'
  get '/show_post/:id' => 'application#show_post'

  get '/new_post' => 'application#new_post'
  post '/create_post' => 'application#create_post'

  get '/edit_post/:id' => 'application#edit_post'
  post '/update_post/:id' => 'application#update_post'

  post 'delete_post/:id' => 'application#delete_post'
end
