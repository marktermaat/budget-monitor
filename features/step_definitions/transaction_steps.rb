require 'digest'

When(/^I post the following transactions:$/) do |table|
  to_transactions(table).each(&method(:post_transaction))
end

Given(/^the following transactions:$/) do |table|
  to_transactions(table).each(&method(:post_transaction))
end

When(/^I request all transactions$/) do
  get_transactions
end

Then(/^I expect the following transactions:$/) do |table|
  expected = to_transactions(table)
  actual = get_transactions
  validate_transactions(expected, actual)
end

Then(/^I expect the result code (\d+)$/) do |result_code|
  expect(last_response.status).to eq result_code.to_i
end

Then(/^I expect the result transaction:$/) do |table|
  expected = to_transactions(table)
  validate_transactions(expected, [@post_result])
end

Then(/^I expect the generated ID to be a MD5 hash of the following fields:$/) do |table|
  actual_id = JSON.parse(last_response.body)['id']
  transaction = to_transactions(table).first
  expected_id = Digest::MD5.hexdigest("#{transaction['timestamp']}#{transaction['description']}#{transaction['amount']}")
  expect(expected_id).to eq(actual_id)
end