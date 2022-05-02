require 'gossip'

class ApplicationController < Sinatra::Base
  # HOME
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
  
  # NEW GOSSIP
  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  # DYNAMIC GOSSIP
  get '/gossips/:id' do
    erb :show, locals: {gossip: Gossip.find("#{params['id']}"), identifiant: "#{params['id']}"}
  end

  # EDIT GOSSIP
  get '/gossips/:id/edit' do
    erb :edit, locals: {identifiant: "#{params['id']}"}
  end

  post '/gossips/:id/edit' do
    Gossip.edit(params["gossip_author"], params["gossip_content"], params['id'])
    redirect '/'
  end

end