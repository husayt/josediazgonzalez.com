# Title: Liquid Exception Handler
# Description: Fixes https://github.com/mojombo/jekyll/issues/46 and https://github.com/mojombo/jekyll/issues/388

module Jekyll
  class Post
    attr_accessor :name
  end
end
