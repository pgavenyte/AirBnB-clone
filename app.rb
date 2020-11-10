require_relative './lib/database_connection'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/setup_database'
require_relative './lib/user'

class MakersBnb < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    "Hello World."
  end

  get '/users/new' do
    flash[:notice] = "Confirm your password." if  User.validate(params[:password], params[:confirm_pass]) == false
    erb(:"users/new")
  end

  post '/users' do
    
  end

end
