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
  %code
    = article[:created_at].strftime '%F'
  = '-'
  %b
    = link_to article[:title], article
  by
  = article[:author]
"""

  engine = Haml::Engine.new markup
  engine.render self, article: article 
end
