require 'sinatra'

class BudgetMonitor < Sinatra::Application
  run! if app_file == $0
end