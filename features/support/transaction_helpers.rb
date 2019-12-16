require 'tempfile'

# table [Cucumber::MultilineArgument::DataTable] Input table
def to_transactions(table)
  table.rows.map do |row|
    row_data = table.column_names.zip(row).map do |column_name, value|
      case column_name
      when 'Id'
        ['key', value]
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
  @post_result = last_response.body
end

def post_transaction_csv(content)
  file = Tempfile.new('csv_transaction')
  file.write(content)
  file.rewind
  post '/transaction/csv', file: Rack::Test::UploadedFile.new(file.path)
  file.close
  file.unlink
  @post_result = last_response.body
end

def get_transactions
  get '/transaction'
  JSON.parse(last_response.body)
end
