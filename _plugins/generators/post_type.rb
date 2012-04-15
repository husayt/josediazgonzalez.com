require 'inflection'
require 'fileutils'
require 'find'

module Jekyll
  # The PostType class creates a single post page for the specified post_type.
  class PostType < Page

    # Initialize a new PostType.
    #   +site+ is the Site
    #   +source+ is the String path to the <source>
    #   +dir+ is the relative path from the base directory to the post type folder.
    #   +name+ is the name of the post_type page to process.
    def initialize(site, base, dir, post_type, post_path, config)
      slug = post_path.sub(/^#{config["folder"]}\/([^\.]+)\..*/, '\1')
      name = post_path.sub(/^#{config["folder"]}\//, '\1')
      @site = site
      @base = base
      @dir = File.join(dir, slug)

      self.read_yaml(File.join(base, '_layouts'), "#{config['index_layout']}.html")

      self.read_yaml(@base, post_path)
      self.data['slug'] = slug
      self.data['is_' + post_type] = true

      if self.data.has_key?('date')
        # ensure Time via to_s and reparse
        self.date = Time.parse(self.data["date"].to_s)
      end

      if !self.data.has_key?('layout')
        self.data['layout'] = config["index_layout"]
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
    def initialize(site,  base, dir, post_type, posts, config)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), config["list_layout"] + '.html')
      self.data[::Inflection.plural(post_type)] = posts
      self.data['is_' + post_type] = true
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
          'index_layout'=> "post_type/#{post_type}/index",
          'list_layout' => "post_type/#{post_type}/list",
          'folder'      => "_post_types/#{post_type}",
          'dir_key'     => post_type
        }){ |key, v1, v2| v1 }

        post_type_list = []

        if site.layouts.key? config["index_layout"]
          posts = get_files(config["folder"])
          posts.each do |post_path|
            post = write_posttype_index(site, config["dir_key"], post_type, post_path, config)
            unless post.nil?
              post_type_list << post
            end
          end
        end

        if post_type_list.size > 1 and site.layouts.key? config["list_layout"]
          write_posttype_list(site, config["dir_key"], post_type, post_type_list, config)
        end
      end
    end

    def write_posttype_index(site, dir, post_type, post_path, config)
      index = PostType.new(site, site.source, dir, post_type, post_path, config)
      if index.data['published']
        index.render(site.layouts, site.site_payload)
        index.write(site.dest)
        site.static_files << index
        return index
      end
      return nil
    end

    def write_posttype_list(site, dir, post_type, posts, config)
      index = PostTypeList.new(site, site.source, dir, post_type, posts, config)
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
        if file=~/.markdown$/ or file=~/.textile$/
          files << file
        end
      end

      files
    end
  end

end