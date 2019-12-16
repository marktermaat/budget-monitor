require 'json'

class BudgetMonitor < Sinatra::Application
  get '/rule' do
    Rule.all.map {|t| t.to_object}.to_json
  end

  post '/rule' do
    data = JSON.parse(request.body.read)
    rule = Service::NewRuleService.create_rule(data)
    if (rule.valid?)
      status 200
      rule.save.to_object.to_json
    else
      status 400
      rule.errors.to_json
    end
  end
end