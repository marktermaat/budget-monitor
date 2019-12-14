require 'digest'

class Transaction < Sequel::Model
  plugin :validation_helpers

  def before_save
    super
    self.id = Digest::MD5.hexdigest("#{timestamp.utc.iso8601}#{description}#{amount}")
  end

  def validate
    super
    validates_presence [:timestamp, :description, :sign, :amount]
  end

  def to_object
    {
        id: id,
        timestamp: timestamp.utc.iso8601,
        description: description,
        sign: sign,
        amount: amount.round(2)
    }
  end
end