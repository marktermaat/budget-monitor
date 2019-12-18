require 'tempfile'

# table [Cucumber::MultilineArgument::DataTable] Input table
def to_rules(table)
  table.rows.map do |row|
    row_data = table.column_names.zip(row).map do |column_name, value|
      case column_name
      when 'Id'
        ['id', value.to_i]
      when 'Pattern'
        ['pattern', value]
      when 'Tag Id'
        ['tag_id', value.nil? ? nil : value.to_i]
      when 'Tag Name'
        ['tag_name', value]
      else
        raise ArgumentError.new("Unknown Transaction column #{column_name}")
      end
    end
    Hash[row_data]
  end
end

def save_rule(rule)
  r = Rule.new(pattern: rule['pattern'], tag_id: rule['tag_id'])
  r.strict_param_setting = false
  r.id = rule['id']
  r.save
end

def update_rule(rule)
  put "/rule/#{rule['id']}", rule.to_json
  @post_result = last_response.body
end

def post_rule(rule)
  post '/rule', rule.to_json
  @post_result = last_response.body
end

def get_rules
  get '/rule'
  JSON.parse(last_response.body)
end

def get_db_rules
  Rule.all.map { |r| r.to_object }
end

def delete_rule(rule_id)
  delete "/rule/#{rule_id}"
end