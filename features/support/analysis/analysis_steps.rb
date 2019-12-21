When(/^I run the analysis$/) do
  Service::TransactionAnalysisService.analyse
end

Then(/^I expect the following tagged transactions:$/) do |table|
  expected = to_transactions_tags(table)
  actual = get_transaction_tags
  validate(expected, actual)
end

Then(/^I expect not tags for the latest transaction$/) do
  expect(Transaction.last.tags).to be_empty
end