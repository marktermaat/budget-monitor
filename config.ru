require 'sequel'

default_connection_string = 'postgres://localhost/budget_monitor'
DB = Sequel.connect(ENV["DATABASE_URL"] || default_connection_string)

Sequel.extension :migration, :core_extensions
Sequel::Migrator.run(DB, './migrations', :use_transactions=>true)

require_relative 'lib/budget_monitor.rb'
run BudgetMonitor