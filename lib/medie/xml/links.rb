require 'active_support/core_ext/array/wrap'

module Medie
  module Xml
    class Links
      def initialize(links=nil)
        @hash = {}

        Array.wrap(links).each do |l|
          link = Medie::Link.new(l)
          @hash[link.rel.to_s] = link
        end
      end

      def [](name)
        @hash[name]
      end
  
      def size
        @hash.size
      end
  
      def keys
        @hash.keys
      end
  
      def method_missing(sym, *args)
        raise "Links can not receive arguments" unless args.empty?
        self[sym.to_s]
      end
    end
  end
end
