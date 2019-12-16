require 'rack/test'
include Rack::Test::Methods

# Setting up test DB
ENV['DATABASE_URL'] = 'postgres://localhost/budget_monitor_test'
require_relative '../../boot'

Before do
  DB[:transaction_tags].delete
  DB[:transactions].delete
  DB[:rules].delete
  DB[:tags].delete
end

module AppHelper
  def app
    BudgetMonitor
  end
end

World(Rack::Test::Methods, AppHelper)