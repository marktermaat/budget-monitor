class BudgetMonitor < Sinatra::Application
  get '/' do
    erb :index
  end
end