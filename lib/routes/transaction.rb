require 'sinatra'
require 'json'
require_relative '../models/transaction'

class BudgetMonitor < Sinatra::Application
  get '/transaction' do
    Transaction.all.map {|t| t.to_object}.to_json
  end

  post '/transaction' do
    body = request.body.read
    transaction = JSON.parse(body)
    Transaction.insert(transaction)
    ''
  end
end