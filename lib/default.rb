# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

require 'haml'

include Nanoc::Helpers::Blogging
include Nanoc::Helpers::LinkTo

def bypass? extension
  ['css','svg'].include? extension
end

def short article
  markup = 
"""
.row.article-entry
  %span.description
    %code
      = article[:created_at].strftime '%F'
    = '-'
    %b
      = link_to article[:title], article
    by
    = article[:author]
  .tags
    - tags_for( article ).each do |one_tag|
      - similarly_tagged = items_tagged_with( one_tag )
      - similarly_tagged.delete(article)
      - if similarly_tagged.any?
        %a.one-tag{ href: link_to_tag( one_tag ), rel: 'tag' }
          %span
            %i.icon-tag
            = one_tag
"""

  Haml::Template.options[:escape_html] = false
  engine = Haml::Template.new() { markup }
  engine.render self, article: article
end
