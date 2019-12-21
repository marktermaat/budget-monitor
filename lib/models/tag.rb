class Tag < Sequel::Model
  plugin :validation_helpers

  one_to_many :rules
  many_to_many :transactions, join_table: :transaction_tags

  def validate
    super
    validates_presence [:name]
  end

  def to_object
    {
        'id' => id,
        'name' => name
    }
  end
end