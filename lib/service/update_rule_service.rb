module Service
  class UpdateRuleService
    def self.update_rule(id, data)
      rule = Rule.find(id: id)
      raise NotFoundError.new("Rule #{id} not found") if rule.nil?

      tag = find_or_create_tag(data)
      rule.set(pattern: data['pattern'], tag_id: tag.id)
    end

    private

    def self.find_or_create_tag(data)
      if !data['tag_id'].nil?
        result = Tag.find(id: data['tag_id'])
        result
      elsif !data['tag_name'].nil?
        Tag.new(name: data['tag_name']).save
      else
        raise BadRequestError.new('missing tag_id or tag_name')
      end
    end
  end
end