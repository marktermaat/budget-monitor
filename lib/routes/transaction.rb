require 'sinatra'
require 'json'
require_relative '../models/transaction'

class BudgetMonitor < Sinatra::Application
  get '/transaction' do
    Transaction.all.map {|t| t.to_object}.to_json
  end

  post '/transaction' do
    begin
      body = request.body.read
      transaction = JSON.parse(body)
      Transaction.insert(transaction)
    rescue JSON::ParserError => e
      halt 400, 'Parse error'
    rescue => e
      puts e.message
    end
    ''
  end
end