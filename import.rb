require 'sequel'
require 'kramdown'
require 'fileutils'

DB = Sequel.connect 'do:mysql://admin:MHEeng9_a1RW@127.0.0.1/blog'

node_sql = """
select n.title, n.created, n.nid, n.uid, b.body_format, b.body_value
from node n, field_data_body b
where type = 'article' and n.nid = b.entity_id
"""


def path_from_node id
  result = DB["select alias from url_alias where source = 'node/#{id}'"]
  path = "content/#{result[:alias][:alias]}"
  parts = path.split('/')
  if path.split('/').size == 5
    parts = [path[0], path[1], path[2], path[4]]
    path = parts.join '/'
  end
  unless path =~ /\.html$/
    path << '.html'
  end
end

def post_content node
  body = node[:body_value]
  node[:body_format] == 'markdown' ? Kramdown::Document.new(body).to_html : body
end

def timestamp hash
  Time.at hash[:created].to_i
end

def meta node
  author = 'hardy' if node[:uid] == 12
  author = 'fredrik' if node[:uid] == 13
  """---
title: #{node[:title]}
kind: article
created_at: #{timestamp(node).strftime "%Y-%m-%d %T"}
author: #{author}
---
  """
end

def create_directories_from path
  parts = path.split '/'
  parts.pop
  directory_path = parts.join '/'
  FileUtils.mkdir_p directory_path
end

def post_comment node
  comment_sql = """
  select c.name, c.created, fc.comment_body_value
  from comment c, field_data_comment_body fc
  where c.nid = #{node[:nid]} and fc.entity_id = c.cid
  order by c.created
  """
  comments = DB[comment_sql]

  if comments.count == 0
    nil
  else
    results = '<div class="old-comments"><h2>Old comments</h2>'
    comments.each do |one_comment|
      results << '<div class="one-old-comment">'
      results << '<span class="comment-date">'
      results << timestamp(one_comment).strftime("%Y-%m-%d")
      results << '</span>'
      results << '<span class="commenter-name">'
      results << one_comment[:name]
      results << '</span>'

      results << '<div class="comment-body">'
      results << one_comment[:comment_body_value]
      results << '</div>'


      results << '</div>'
    end
    results << '</div>'
  end
end

DB[node_sql].each do |node|
  path = path_from_node node[:nid]
  create_directories_from path
  File.open( path, "w" ) do |f|
    f.write meta node
    f.write post_content(node)
    comment = post_comment node
    f.write comment if comment
  end
end
