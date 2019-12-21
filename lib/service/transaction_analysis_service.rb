module Service
  class TransactionAnalysisService
    def self.analyse
      rules = Rule.all
      Transaction.each do |transaction|
        rules.each do |rule|
          regex = Regexp.new(rule.pattern)
          if transaction.description.match(regex) || transaction.account.match(regex)
            tag = Tag.find(id: rule.tag_id)
            transaction.add_tag(tag)
          end
        end
      end
    end
  end
end