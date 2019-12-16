require 'json'

class BudgetMonitor < Sinatra::Application
  get '/tag' do
    Tag.all.map {|t| t.to_object}.to_json
  end
end