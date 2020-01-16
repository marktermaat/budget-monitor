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
      result = rule.save.to_object.to_json
      AnalyseTransactionsJob.perform_async
      result
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
      result = rule.save.to_object.to_json
      AnalyseTransactionsJob.perform_async
      result
    else
      status 400
      rule.errors.to_json
    end
  end

  delete '/rule/:id' do
    rule = Rule.find(id: params['id'])
    if !rule.nil?
      rule.delete
      AnalyseTransactionsJob.perform_async
    else
      raise NotFoundError.new("Rule #{params['id']} not found.")
    end
    200
  end

  get '/rule/test' do
    pattern = params[:pattern]
    return [].to_json if pattern.nil? || pattern.empty?

    regex = Regexp.new(pattern.downcase)
    tagged_results = Transaction
                         .left_join(:transaction_tags, transaction_id: :id)
                         .exclude(tag_id: nil)
                         .all
                         .select {|t| t.description.downcase.match(regex) || t.account.downcase.match(regex)}
                         .count;
    untagged_results = Transaction
        .left_join(:transaction_tags, transaction_id: :id)
        .where(tag_id: nil)
        .all
        .select {|t| t.description.match(regex) || t.account.match(regex)}
        .map {|t| t.to_object}
    {no_tagged_results: tagged_results, results: untagged_results}.to_json
  end
end