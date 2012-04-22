# Title: Coffee
# Source: https://gist.github.com/959938
# Description: Allows you to use coffeescript instead of javascript

require 'coffee-script'

module Jekyll
  class CoffeeScriptConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /coffee/i
    end

    def output_ext(ext)
      ".js"
    end

    def convert(content)
      begin
        CoffeeScript.compile content
      rescue StandardError => e
        puts "CoffeeScript error:" + e.message
      end
    end
  end
end