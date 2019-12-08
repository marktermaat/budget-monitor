When(/^I post the following transactions:$/) do |table|
  transactions = to_transactions(table)
  transactions.each do |transaction|
    post '/transaction', transaction.to_json
    expect(last_response.status).to eq(200), "Posting transaction failed, received status code #{last_response.status}"
  end
end

Then(/^I expect the following transactions:$/) do |table|
  expected = to_transactions(table)
  get '/transaction'
  transactions = JSON.parse(last_response.body)
  expected.each_with_index do |expected_transaction, index|
    expected_transaction.each do |key, value|
      expect(transactions[index][key]).to eq value
    end
  end

end