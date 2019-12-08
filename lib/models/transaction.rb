class Transaction < Sequel::Model
  def to_object
    {
        id: id,
        timestamp: timestamp.utc.iso8601,
        description: description,
        sign: sign,
        amount: amount
    }
  end
end