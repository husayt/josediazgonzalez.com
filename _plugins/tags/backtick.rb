require './_plugins/extensions/post_filter'
require 'rubypants'

module Jekyll
  class BacktickCodeBlockFilter < PostFilter
    def initialize(config)
      @tag = "highlight"
      if config.key?('backtick') and config['backtick'].key?('tag')
        @tag = config['backtick']['tag']
      end
      super
    end

    def pre_render(post)
      post.content = post.content.gsub(/^`{3} (.*)$/, "{% #{@tag} \\1 %}")
      post.content = post.content.gsub(/^`{3}$/, "{% end#{@tag} %}")
    end

    def post_render(post)
      post.content
    end
  end
end