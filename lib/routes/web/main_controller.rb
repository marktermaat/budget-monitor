class BudgetMonitor < Sinatra::Application
  get '/' do
    erb :index
  end

  get '/rules' do
    rules = Rule.order(:tag_id, :pattern).map { |r| r.to_object }
    erb :'rules/index', locals: { rules: rules }
  end

  get '/rules/new' do
    erb :'rules/new'
  end

  get '/tags' do
    tags = Tag.all.map {|t| t.to_object}
    erb :tags, locals: { tags: tags }
  end

  get '/import' do
    erb :import
  end

  get '/untagged' do
    transactions = Transaction
        .eager_graph(:tags)
        .all
        .select {|t| t.tags.empty?}
        .select {|t| t.sign == 'minus'}
        .sort_by {|t| t.amount}
        .reverse
        .take(100)
    puts transactions.inspect
    erb :untagged, locals: { transactions: transactions }
  end
end