module Service
  class TransactionAnalysisService
    @@mutex = Mutex.new

    def self.analyse
      child_pid = Process.fork do
        analyse_async
        Process.exit
      end
      Process.detach child_pid
    end

    def self.analyse_async
      @@mutex.synchronize do
        rules = Rule.all
        Transaction.each do |transaction|
          rules.each do |rule|
            regex = Regexp.new(rule.pattern)
            if transaction.description.downcase.match(regex) || transaction.account.downcase.match(regex)
              tag = Tag.find(id: rule.tag_id)
              transaction.add_tag(tag)
            end
          end
        end
      end
    end
  end
end