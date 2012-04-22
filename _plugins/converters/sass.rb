# Title: Sass
# Source: https://gist.github.com/1942866
# Description: Allows you to use sass instead of css

require 'sass'

module Jekyll
  class SassConverter < Converter
    safe true
    priority :low

    attr_accessor :sass_style

    def matches(ext)
      if ext =~ /sass/i
        @sass_syntax = :sass
      elsif ext =~ /scss/i
        @sass_syntax = :scss
      else
        false
      end
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      engine = Sass::Engine.new(content, :syntax => @sass_syntax)
      engine.render
    end
  end
end