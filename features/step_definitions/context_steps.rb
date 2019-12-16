Given(/^that now is (.*)$/) do |timestamp|
  @times = @times || {}
  @times[:now] = Time.parse(timestamp)
end

Then(/^I expect the result code (\d+)$/) do |result_code|
  expect(last_response.status).to eq result_code.to_i
end