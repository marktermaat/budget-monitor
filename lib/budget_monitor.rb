require 'sinatra'
require_relative './models/transaction'

class BudgetMonitor < Sinatra::Application

  get '/' do
    'Hello world'
  end

  get '/transaction' do
    Transaction.all.to_json
  end

  %w{models}.each {|dir| Dir.glob("./#{dir}/*.rb", &method(:require_relative))}
  run! if app_file == $0
end