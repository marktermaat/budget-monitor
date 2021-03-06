require 'sequel'
require 'logger'
require 'sucker_punch'
require 'sinatra/flash'

default_connection_string = 'postgres://localhost/budget_monitor'
DB = Sequel.connect(ENV["DATABASE_URL"] || default_connection_string)
DB.loggers << Logger.new($stdout)

Sequel.extension :migration, :core_extensions
Sequel::Migrator.run(DB, './migrations', :use_transactions=>true)
Sequel.default_timezone = :utc

Dir[File.expand_path('../lib/**/*.rb', __FILE__)].each do |file|
  dirname = File.dirname(file)
  file_basename = File.basename(file, File.extname(file))
  require "#{dirname}/#{file_basename}"
end

require_relative 'lib/budget_monitor.rb'