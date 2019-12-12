def validate_transactions(expected, actual)
  expected.each_with_index do |expected_transaction, index|
    expected_transaction.each do |key, value|
      expect(actual[index][key]).to eq(value), "Value #{actual[index][key]} is not equal to expected value #{value}"
    end
  end
end