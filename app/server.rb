require "data_mapper"
require 'sinatra'
require 'rack-flash'
require './lib/link'
require './lib/tag'
require './lib/user'

require_relative 'helpers/application'
require_relative 'helpers/sessions'
require_relative 'helpers/links'
require_relative 'helpers/users'
require_relative 'helpers/tags'

use Rack::Flash

env = ENV["RACK_ENV"] || "development"
# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

 # this needs to be done after datamapper is initialis your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'



