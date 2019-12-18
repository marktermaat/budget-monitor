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

  put '/rule/:id' do
    data = JSON.parse(request.body.read)
    rule = Service::UpdateRuleService.update_rule(params['id'], data)
    if rule.valid?
      status 200
      rule.save.to_object.to_json
    else
      status 400
      rule.errors.to_json
    end
  end

  delete '/rule/:id' do
    rule = Rule.find(id: params['id'])
    if !rule.nil?
      rule.delete
    else
      raise NotFoundError.new("Rule #{params['id']} not found.")
    end
  end
end