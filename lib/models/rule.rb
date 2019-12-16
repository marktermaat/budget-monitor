class Rule < Sequel::Model
  plugin :validation_helpers

  many_to_one :tag

  def validate
    super
    validates_presence [:pattern]
  end

  def to_object
    {
        id: id,
        pattern: pattern,
        tag_id: tag_id,
        tag_name: tag.name
    }
  end
end