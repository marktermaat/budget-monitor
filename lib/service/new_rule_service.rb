module Service
  class NewRuleService
    def self.create_rule(data)
      puts "Received data: #{data.inspect}"
      tag = find_or_create_tag(data)
      rule = Rule.new({pattern: data['pattern'], tag_id: tag.id})
    end

    private

    def self.find_or_create_tag(data)
      puts data.inspect
      if !data['tag_id'].nil?
        result = Tag.find(id: data['tag_id'])
        puts "Result: #{result.inspect}"
        result
      elsif !data['tag_name'].nil?
        Tag.new(name: data['tag_name']).save
      else
        halt 400, "missing tag_id or tag_name"
      end
    end
  end
end