class BudgetMonitor < Sinatra::Application
  get '/' do
    erb :index
  end

  get '/rules' do
    erb :rules
  end

  get '/import' do
    erb :import
  end
end