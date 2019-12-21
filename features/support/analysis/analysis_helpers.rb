def to_transactions_tags(table)
  table.rows.map do |row|
    row_data = table.column_names.zip(row).map do |column_name, value|
      case column_name
      when 'Transaction Id'
        ['transaction_id', get_transaction_id(value)]
      when 'Tag Id'
        ['tag_id', value.to_i]
      else
        raise ArgumentError.new("Unknown Transaction column #{column_name}")
      end
    end
    Hash[row_data]
  end
end

def get_transaction_id(value)
  return Transaction.last[:id] if value == 'latest'
  return value.to_i
end

def get_transaction_tags
  t = Transaction.all
  Transaction.all.map do |transaction|
    transaction.tags.map { |tag| { 'transaction_id' => transaction.id, 'tag_id' => tag.id }  }
  end.flatten
end