def tags_for item
  if item[:tags]
    item[:tags].split(',').map {|tag| tag.strip }
  else
    []
  end
end

def items_tagged_with tag, except = []
  other_items = @items - except
  other_items.select do |item|
    tags_for(item).include?(tag)
  end
end

def items_without_tags
  @items.select { |i| tags_for(i).empty? }
end

def tags_with_sibling_articles_for item
  tags_for( @item ).each do |one_tag|
    similar_articles = items_tagged_with one_tag, [@item]
    if similar_articles.any?
      yield one_tag, similar_articles
    end
  end
end
