# table [Cucumber::MultilineArgument::DataTable] Input table
def to_transactions(table)
  table.rows.map do |row|
    row_data = table.column_names.zip(row).map do |column_name, value|
      case column_name
      when 'Id'
        ['id', value]
      when 'Timestamp'
        ['timestamp', convert_timestamp(value).utc.iso8601]
      when 'Description'
        ['description', value]
      when 'Sign'
        ['sign', value]
      when 'Amount'
        ['amount', value.to_f.round(2)]
      else
        raise ArgumentError.new("Unknown Transaction column #{column_name}")
      end
    end
    Hash[row_data]
  end
end

def post_transaction(transaction)
  post '/transaction', transaction.to_json
  @post_result = JSON.parse(last_response.body)
end

def get_transactions
  get '/transaction'
  JSON.parse(last_response.body)
end
