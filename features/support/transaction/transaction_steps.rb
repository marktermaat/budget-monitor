require 'digest'

Given(/^the following transactions:$/) do |table|
  to_transactions(table).each(&method(:post_transaction))
end

When(/^I post the following transactions:$/) do |table|
  to_transactions(table).each(&method(:post_transaction))
end

When(/^I request all transactions$/) do
  get_transactions
end

When(/^I post the following transactions as csv:$/) do |table|
  post_transaction_csv(table.rows.join("\n"))
end

Then(/^I expect the following transactions:$/) do |table|
  expected = to_transactions(table)
  actual = get_transactions
  validate(expected, actual)
end

Then(/^I expect the result transaction:$/) do |table|
  expected = to_transactions(table)
  actual = JSON.parse(@post_result)
  validate(expected, actual)
end

Then(/^I expect the generated key to be a MD5 hash of the following fields:$/) do |table|
  received_transaction = JSON.parse(last_response.body)
  actual_id = received_transaction.kind_of?(Array) ? received_transaction[0]['key'] : received_transaction['key']
  transaction = to_transactions(table).first
  expected_id = Digest::MD5.hexdigest("#{transaction['timestamp']}#{transaction['description']}#{transaction['amount']}")
  expect(expected_id).to eq(actual_id)
end