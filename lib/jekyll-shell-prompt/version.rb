# Prevent bundler from raising an
# error as Liquid is yet to load here
#module Liquid; class Block; end; end;

module Jekyll
  class Shell
    VERSION = "0.1.0"
  end
end
