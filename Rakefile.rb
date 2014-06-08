BUILD_DIR = "./build"
  
FOOTBALL_DB_PATH = "#{BUILD_DIR}/football.db"

DB_CONFIG = {
  :adapter   =>  'postgresql',
  :database  =>  FOOTBALL_DB_PATH,
  username: 'postgres',
  password: 'code*03'
}

directory BUILD_DIR

task :clean do
  rm FOOTBALL_DB_PATH if File.exists?( FOOTBALL_DB_PATH )
end

task :env => BUILD_DIR do
 require 'worlddb'  
 require 'sportdb'
 require 'logutils/db'

 LogUtils::Logger.root.level = :info

 pp DB_CONFIG
 ActiveRecord::Base.establish_connection( DB_CONFIG )
end

task :create => :env do
  LogDb.create
  WorldDb.create
  SportDb.create
end
  
task :importworld => :env do
  WorldDb.read_setup( 'setups/sport.db.admin', '../world.db', skip_tags: true )  # populate world tables
  # WorldDb.stats
end

task :importsport => :env do
  SportDb.read_builtin
  SportDb.read_setup( 'setups/all', '../world-cup' )
  #SportDb.read_setup( 'setups/all', '../at-austria' )
  # SportDb.stats
end

desc 'footballdb - build from scratch'
task :build => [:clean, :create, :importworld, :importsport] do
  puts 'Done.'
end 