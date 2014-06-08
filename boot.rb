
#ENV['RACK_ENV'] ||= 'development'
ENV['RACK_ENV'] ||= 'production'

puts "ENV['RACK_ENV'] = #{ENV['RACK_ENV']}"

require 'bundler'

# ruby core n stdlibs
require 'json'
require 'uri'
require 'logger'
require 'pp'

# 3rd party gems via bundler (see Gemfile)
Bundler.setup
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

# Database Setup & Config

db_config = {
  #adapter:  'sqlite3',
  # adapter: 'postgresql',
  # #database: 'football',
  # database: 'hudlwcapi_prod',
  # username: 'postgres',
  # password: 'code*03'    # NOTE: change to use your db of choice (e.g. worldcup.db, bundesliga.db, ski.db etc.)
    adapter: 'postgresql',
  database: 'd6vv46ice2jscv',
  username: 'wfjlgnuichedor',
  password: 'zm90p7LR0diJ3SoA8_2fEpZuT'
}

pp db_config
ActiveRecord::Base.establish_connection( db_config )

## for debugging - disable for production use
ActiveRecord::Base.logger = Logger.new( STDOUT )


require './server.rb'
