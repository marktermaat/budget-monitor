Given(/^that now is (.*)$/) do |timestamp|
  @times = @times || {}
  @times[:now] = Time.parse(timestamp)
end