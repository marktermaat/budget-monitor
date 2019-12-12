require 'sinatra'
require 'json'
require 'digest'

class BudgetMonitor < Sinatra::Application
  get '/transaction' do
    Transaction.all.map {|t| t.to_object}.to_json
  end

  post '/transaction' do
    data = JSON.parse(request.body.read)
    transaction = Transaction.new(data)
    transaction.id = Digest::MD5.hexdigest("#{data['timestamp']}#{data['description']}#{data['amount']}")
    if (transaction.valid?)
      status 200
      transaction.save.to_object.to_json
    else
      status 400
      transaction.errors.to_json
    end
  end
end