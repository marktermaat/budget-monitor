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

  get '/import' do
    erb :import
  end
end