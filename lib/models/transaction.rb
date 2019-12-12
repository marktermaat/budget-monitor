class Transaction < Sequel::Model
  plugin :validation_helpers

  def validate
    super

    validates_presence [:id, :timestamp, :description, :sign, :amount]
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