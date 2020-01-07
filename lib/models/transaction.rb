require 'digest'

class Transaction < Sequel::Model
  plugin :validation_helpers

  many_to_many :tags, join_table: :transaction_tags

  def validate
    super
    validates_presence [:timestamp, :description, :sign, :amount]
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