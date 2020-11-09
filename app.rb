require_relative './lib/database_connection'
require 'Sinatra/base'
require_relative './lib/setup_database'

class MakersBnb < Sinatra::Base

  get '/' do
    "Hello World."
  end

end
