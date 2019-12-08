require 'sinatra'
require_relative './models/transaction'
require_relative './routes/transaction'

class BudgetMonitor < Sinatra::Application

  get '/' do
    'Hello world'
  end

  Sequel.default_timezone = :utc
  run! if app_file == $0
end