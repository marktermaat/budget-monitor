require 'csv'

module Service
  class IngCsvService
    COLUMN_SEPARATOR = ','

    def self.read_csv(content)
      table = CSV.parse(content, col_sep: COLUMN_SEPARATOR, headers: true)
      table.map do |row|
        timestamp = Date.strptime(row['Datum'], '%Y%m%d').to_datetime
        description = row['Naam / Omschrijving']
        amount = row['Bedrag (EUR)'].gsub(',', '.').to_f.round(2)
        sign = row['Af Bij'] == 'Af' ? 'minus' : 'plus'
        transaction = Transaction.new(timestamp: timestamp, description: description, sign: sign, amount: amount)
        transaction.save
      end
    end
  end
end