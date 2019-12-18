Given(/^the following rules:$/) do |table|
  to_rules(table).each(&method(:save_rule))
end

Given(/^I update the following rule:$/) do |table|
  to_rules(table).each(&method(:update_rule))
end

When(/^I request all rules$/) do
  get_rules
end

When(/^I post the following rules:$/) do |table|
  to_rules(table).each(&method(:post_rule))
end

When(/^I delete rule (\d+)$/) do |rule_id|
  delete_rule(rule_id)
end

Then(/^I expect the following rules:$/) do |table|
  expected = to_rules(table)
  actual = get_rules
  validate(expected, actual)
end

Then(/^I expect the following rules in the database:$/) do |table|
  expected = to_rules(table)
  actual = get_db_rules
  validate(expected, actual)
end

Then(/^I expect the result rule:$/) do |table|
  expected = to_rules(table)
  actual = JSON.parse(@post_result)
  validate(expected, actual)
end

Then(/^I expect (\d+) rules in the database$/) do |number_of_rules|
  number_of_stored_rules = get_db_rules.length
  expect(number_of_stored_rules).to eq(number_of_rules.to_i), "Expected database to have #{number_of_rules} rules, but found #{number_of_stored_rules}."
end