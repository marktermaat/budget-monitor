class AnalyseTransactionsJob
  include SuckerPunch::Job
  workers 1

  def perform()
    rules = Rule.all
    DB.transaction do
      puts "Analysing transactions"
      DB.run 'DELETE FROM transaction_tags'
      Transaction.each do |transaction|
        rules.each do |rule|
          regex = Regexp.new(rule.pattern.downcase)
          if transaction.description.downcase.match(regex) || transaction.account.downcase.match(regex)
            tag = Tag.find(id: rule.tag_id)
            transaction.add_tag(tag)
          end
        end
      end
    end
  end
end