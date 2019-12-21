require 'digest'

class Transaction < Sequel::Model
  plugin :validation_helpers

  many_to_many :tags, join_table: :transaction_tags

  def before_save
    super
    self.key = Digest::MD5.hexdigest("#{timestamp.utc.iso8601}#{description}#{amount}")
  end

  def validate
    super
    validates_presence [:timestamp, :description, :account, :sign, :amount]
  end

  def to_object
    {
        'id' => id,
        'key' => key,
        'timestamp' => timestamp.utc.iso8601,
        'description' => description,
        'account' => account,
        'sign' => sign,
        'amount' => amount.round(2)
    }
  end
end