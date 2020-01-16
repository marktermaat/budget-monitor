class BudgetMonitor < Sinatra::Application
  get '/ui/api/untagged_transactions' do
    Transaction
      .eager(:tags)
      .all
      .select {|t| t.tags.empty?}
      .select {|t| t.sign == 'minus'}
      .sort_by {|t| t.amount}
      .reverse
      .take(100)
      .map {|t| t.to_object}
      .to_json
  end

  post '/ui/api/analyse_transactions' do
    AnalyseTransactionsJob.perform_async
  end
end
