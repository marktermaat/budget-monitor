require 'json'

class BudgetMonitor < Sinatra::Application
  get '/transaction' do
    Transaction.all.map {|t| t.to_object}.to_json
  end

  post '/transaction' do
    data = JSON.parse(request.body.read)
    transaction = Transaction.new()
    transaction.set_fields(data, ['timestamp', 'description', 'sign', 'amount'])
    if (transaction.valid?)
      status 200
      result = transaction.save.to_object.to_json
      Service::TransactionAnalysisService.analyse
      result
    else
      status 400
      transaction.errors.to_json
    end
  end

  post '/transaction/csv' do
    content = params[:file][:tempfile].read
    result = Service::IngCsvService.read_csv(content)
    Service::TransactionAnalysisService.analyse
    result.map{|r| r.to_object}.to_json
  end
end