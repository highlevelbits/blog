def tags_for item
  if item[:tags]
    item[:tags].split(',').map {|tag| tag.strip }.sort
  else
    []
  end
end

def items_tagged_with tag, except = []
  @items.reject {|item| except.include? item }.select {|item| tags_for(item).include?(tag) }.sort {|x,y| y[:created_at].to_s <=> x[:created_at].to_s}
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

def link_to_tag tag
  "/tags/#{tag.gsub(' ', '-')}.html"
end
