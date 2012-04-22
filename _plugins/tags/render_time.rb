# Title: render_time
# Source: https://github.com/mojombo/jekyll/wiki/Plugins
# Description: Sample `render_time` tag

module Jekyll
  class RenderTimeTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      "#{@text} #{Time.now}"
    end
  end
end

Liquid::Template.register_tag('render_time', Jekyll::RenderTimeTag)