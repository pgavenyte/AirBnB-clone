require_relative './lib/database_connection'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/setup_database'

class MakersBnb < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    "Hello World."
  end

end
