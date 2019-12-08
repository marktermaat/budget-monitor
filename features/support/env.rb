require 'rack/test'
include Rack::Test::Methods

# Setting up test DB
require 'sequel'
default_connection_string = 'postgres://localhost/budget_monitor_test'
DB = Sequel.connect(ENV["DATABASE_URL"] || default_connection_string)

Sequel.extension :migration, :core_extensions
Sequel::Migrator.run(DB, './migrations', :use_transactions=>true)

Before do
  DB[:transactions].delete
end

require 'budget_monitor'
module AppHelper
  def app
    BudgetMonitor
  end
end

World(Rack::Test::Methods, AppHelper)