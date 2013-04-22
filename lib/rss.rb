require 'simple-rss'
require 'builder'

#shamelessly copied from https://gist.github.com/sangyye/2916860
def rss_feed atom_feed
  atom = SimpleRSS.parse StringIO.new(atom_feed)
  xml = Builder::XmlMarkup.new
    xml.instruct! :xml, :version => '1.0'
    xml.rss :version => "2.0" do
      xml.channel do
        xml.title atom.channel.title
        #xml.description
        xml.link atom.channel.link

        atom.channel.entries.each do |post|
          xml.item do
            xml.title post.title
            xml.link post.link
            xml.description post.content
            xml.pubDate Time.parse(post.updated.to_s).rfc822()
            xml.guid post.link
          end
        end
      end
    end
end