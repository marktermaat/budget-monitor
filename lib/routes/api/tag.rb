require 'json'

class BudgetMonitor < Sinatra::Application
  get '/tag' do
    Tag.all.map {|t| t.to_object}.to_json
  end

  delete '/rule/:id' do
    # Delete tag if no rules are linked to it.
    # Also, show number or rules on tags page
  end
end