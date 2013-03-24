
class Object
  def present?
    understands_empty = self.respond_to?( :empty? )
    not self.nil? and (understands_empty ? self.empty? : true)
  end
end

def tags_for item
  if item[:tags]
    item[:tags].split(',').map {|tag| tag.strip }
  else
    []
  end
end

def items_tagged_with tag, except = []
  other_items = @items - except
  other_items.select do |i|
    (i[:tags] || []).include?(tag)
  end
end

def items_without_tags
  @items.select { |i| not i[:tags].present? }
end

