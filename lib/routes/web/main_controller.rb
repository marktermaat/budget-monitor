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

  get '/rules/:id/delete' do
    rule = Rule.find(id: params['id'])
    if !rule.nil?
      rule.delete
      AnalyseTransactionsJob.perform_async
      flash[:success] = 'Rule deleted'
    else
      flash[:error] = 'Rule not found'
    end
    redirect "/rules"
  end

  get '/tags/:id/delete' do
    # Delete tag if no rules are linked to it.
    # Also, show number or rules on tags page
    tag = Tag.find(id: params[:id])
    if tag.rules.empty?
      tag.destroy
      flash[:success] = 'Tag deleted'
    else
      flash[:error] = 'Tag could not be deleted, it still has rules.'
    end
    redirect "/tags"
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