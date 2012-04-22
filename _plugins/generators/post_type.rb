# Title: PostType
#
# Create custom post type pages, such as galleries or a portfolio,
# similar to one would create new posts

require 'inflection'
require 'fileutils'
require 'find'

module Jekyll
  class PostTypeIndex < Page
    def initialize(site, base, dir, type, post_path, config)
      slug = post_path.sub(/^#{config["folder"]}\/([^\.]+)\..*/, '\1')
      name = post_path.sub(/^#{config["folder"]}\//, '\1')
      @site = site
      @base = base
      @dir = File.join(dir, slug)

      # Use the already cached layout content and data for theme support
      self.content = @site.layouts[type].content
      self.data = @site.layouts[type].data

      # Read in the data from the post
      self.read_yaml(@base, post_path)

      self.data['slug'] = slug
      self.data['is_' + config['post_type']] = true

      if self.data.has_key?('date')
        # ensure Time via to_s and reparse
        self.date = Time.parse(self.data["date"].to_s)
      end

      if !self.data.has_key?('layout')
        self.data['layout'] = type
      end

      # Ignore the post_type page unless it has been marked as published.
      if self.data.has_key?('published') && self.data['published'] == false
        return false
      else
        self.data['published'] = true
      end

      ext = File.extname(name)
      unless ['.textile', '.markdown', '.html'].include?(ext)
        ext = '.textile'
      end

      @name = "index#{ext}"
      self.process(@name)
    end
  end

  class PostTypeList < Page
    def initialize(site,  base, dir, type, posts, config)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      # Use the already cached layout content and data for theme support
      self.content = @site.layouts[type].content
      self.data = @site.layouts[type].data

      self.data[::Inflection.plural(config['post_type'])] = posts
      self.data['is_' + config['post_type']] = true

      self.process(@name)
    end
  end

  # Jekyll hook - the generate method is called by jekyll, and generates all the post_type pages.
  class PostTypeGenerator < Generator
    safe true
    priority :low

    def generate(site)
      if site.config.has_key?('post_types') == false
        return true
      end

      site.config['post_types'].each do |post_type|
        config = {}
        if post_type.is_a?(Hash)
          post_type, config['page_dir'] = post_type.shift
        elsif post_type.is_a?(Array)
          post_type, config = post_type
        end

        config = {} if config.nil?

        config = config.merge!({
          'page_title'  => post_type.capitalize + ': ',
          'folder'      => "_post_types/#{post_type}",
          'post_type'   => post_type,
          'dir'         => post_type,
        }){ |key, v1, v2| v1 }

        post_type_list = []

        type = "post_type/#{post_type}/index"
        if site.layouts.key?(type)
          posts = get_files(config["folder"])
          posts.each do |post_path|
            post = write_index(site, config['dir'], type, post_path, config)
            post_type_list << post unless post.nil?
          end
        end

        type = "post_type/#{post_type}/list"
        if post_type_list.size > 1 and site.layouts.key? type
          write_list(site, config['dir'], type, post_type_list, config)
        end
      end
    end

    def write_index(site, dir, type, post_path, config)
      index = PostTypeIndex.new(site, site.source, dir, type, post_path, config)
      return nil if not index.data['published']

      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.static_files << index
      index
    end

    def write_list(site, dir, type, posts, config)
      index = PostTypeList.new(site, site.source, dir, type, posts, config)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.static_files << index
    end

    # Gets a list of files in the _posttype folder with a .markdown or .textile extension.
    #
    # Return Array list of post config files.
    def get_files(folder)
      files = []
      Find.find(folder) do |file|
        files << file if file=~/.(markdown|textile)$/
      end

      files
    end
  end
end