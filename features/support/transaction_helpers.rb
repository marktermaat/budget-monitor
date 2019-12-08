# table [Cucumber::MultilineArgument::DataTable] Input table
def to_transactions(table)
  table.rows.map do |row|
    row_data = table.column_names.zip(row).map do |column_name, value|
      case column_name
      when 'Timestamp'
        ['timestamp', convert_timestamp(value).utc.iso8601]
      when 'Description'
        ['description', value]
      else
        raise ArgumentError.new("Unknown Transaction column #{column_name}")
      end
    end
    Hash[row_data]
  end
end
