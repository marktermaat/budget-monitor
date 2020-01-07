module Service
  class SaveTransactionService
    def self.save(transaction)
      key = Digest::MD5.hexdigest("#{transaction.timestamp.utc.iso8601}#{transaction.description}#{transaction.amount}")
      if Transaction.where(key: key).empty?
        transaction.key = key
        transaction.save
      else
        # Transaction with this ID already exists, ignoring.
        Transaction.find(key: key)
      end
    end
  end
end