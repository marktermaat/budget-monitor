require 'csv'

module Service
  class IngCsvService
    COLUMN_SEPARATOR = ','

    def self.read_csv(content)
      table = CSV.parse(content, col_sep: COLUMN_SEPARATOR, headers: true)
      table.map do |row|
        transaction = Transaction.new(transaction_hash(row))
        transaction.save
      end
    end

    private

    def self.transaction_hash(row)
      timestamp = Date.strptime(row['Datum'], '%Y%m%d').to_datetime
      description = row['Naam / Omschrijving']
      amount = row['Bedrag (EUR)'].gsub(',', '.').to_f.round(2)
      sign = row['Af Bij'] == 'Af' ? 'minus' : 'plus'

      {timestamp: timestamp, description: description, sign: sign, amount: amount}
    end
  end
end