Then(/^I expect the following tagged transactions:$/) do |table|
  expected = to_transactions_tags(table)
  actual = get_transaction_tags
  validate(expected, actual)
end
