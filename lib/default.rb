# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

include Nanoc::Helpers::Blogging
include Nanoc::Helpers::LinkTo

def bypass? extension
  ['css','svg'].include? extension
end
