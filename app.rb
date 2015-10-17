Dotenv.load

require 'uri'

# Can be used in ./cookie.rb like User.find, User.all etc
require './models/user'
require './models/template'

class App < Sinatra::Base
  configure do
    enable :logging
    enable :sessions
  end
  set :environment, ENV['RACK_ENV']
  set :public_folder, Proc.new { File.join(root, "public") }
  set :views, Proc.new { File.join(root, "templates") }
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  require "./lib/cookie"
end
