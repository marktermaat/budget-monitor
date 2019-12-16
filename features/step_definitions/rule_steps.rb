Given(/^the following rules:$/) do |table|
  to_rules(table).each(&method(:save_rule))
end

When(/^I request all rules$/) do
  get_rules
end

When(/^I post the following rules:$/) do |table|
  to_rules(table).each(&method(:post_rule))
end

Then(/^I expect the following rules:$/) do |table|
  expected = to_rules(table)
  actual = get_rules
  validate(expected, actual)
end

Then(/^I expect the result rule:$/) do |table|
  expected = to_rules(table)
  actual = JSON.parse(@post_result)
  validate(expected, actual)
end