require 'tempfile'

# table [Cucumber::MultilineArgument::DataTable] Input table
def to_tags(table)
  table.rows.map do |row|
    row_data = table.column_names.zip(row).map do |column_name, value|
      case column_name
      when 'Id'
        ['id', value.to_i]
      when 'Name'
        ['name', value]
      else
        raise ArgumentError.new("Unknown Transaction column #{column_name}")
      end
    end
    Hash[row_data]
  end
end

def save_tag(tag)
  t = Tag.new(name: tag['name'])
  t.strict_param_setting = false
  t.id = tag['id']
  t.save
end

def get_tags
  get '/tag'
  JSON.parse(last_response.body)
end
