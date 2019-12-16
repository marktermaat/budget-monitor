Given(/^the following tags:$/) do |table|
  to_tags(table).each(&method(:save_tag))
end

When(/^I request all tags$/) do
  get_tags
end

Then(/^I expect the following tags:$/) do |table|
  expected = to_tags(table)
  actual = get_tags
  validate(expected, actual)
end