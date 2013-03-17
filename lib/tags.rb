
def tags_for item
  if item[:tags]
    item[:tags].split(',').map {|tag| tag.strip }
  else
    []
  end
end
