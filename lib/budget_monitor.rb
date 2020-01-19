require 'sinatra'
require "sinatra/reloader" if development?

class BudgetMonitor < Sinatra::Application
  enable :sessions
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

  run! if app_file == $0
end