def validate(expected, actual)
  expected.each_with_index do |expected_transaction, index|
    expected_transaction.each do |key, value|
      actual_value = actual.kind_of?(Array) ? actual[index][key] : actual[key]
      expect(actual_value).to eq(value), "Value #{actual_value} is not equal to expected value #{value}"
    end
  end
end