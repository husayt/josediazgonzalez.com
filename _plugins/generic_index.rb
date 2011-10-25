require 'inflection'

module Jekyll
  class GenericPageTypeIndex < Page
    attr_accessor :page_type

    def initialize(site, base, dir, page, page_type, do_related)
      @page_type = page_type
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), "#{@page_type}_index.html")
      self.data[@page_type] = page

      if do_related
        self.data['related'] = []
        site_coll = site.send ::Inflection.plural(page_type)
        site_coll[page].each do |post|
          post_coll = post.send ::Inflection.plural(page_type)
          post_coll.each do |rel|
            self.data['related'].push(rel)
          end
        end
        self.data['related'] = self.data['related'].uniq
      end

      page_title_prefix = site.config["#{@page_type}_title_prefix"] || 'GenericPageTypes: '
      self.data['title'] = "#{page_title_prefix}#{page}"
    end
  end

  class GenericPageTypeList < Page
    attr_accessor :page_type

    def initialize(site,  base, dir, pages, page_type)
      @page_type = page_type
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), "#{@page_type}_list.html")
      self.data[::Inflection.plural(@page_type)] = pages
    end
  end

  class GenericPageGenerator < Generator
    safe true

    def generate(site)
      if site.config.has_key?('index_pages') == false
        return true
      end

      site.config['index_pages'].each do |page_type|
        do_related = false
        if page_type.is_a?(Hash)
          page_type, do_related = page_type.shift
        end

        dir = site.config["#{page_type}_dir"] || ::Inflection.plural(page_type)

        page_types = site.send ::Inflection.plural(page_type)

        if page_types && site.layouts.key?("#{page_type}_index")
          page_types.keys.each do |page|
            write_index(site, File.join(dir, page.gsub(/\s/, "-").gsub(/[^\w-]/, '').downcase), page, page_type, do_related)
          end
        end

        if page_types && site.layouts.key?("#{page_type}_list")
          write_list(site, dir, page_types.keys.sort, page_type)
        end
      end
    end

    def write_index(site, dir, page, page_type, do_related)
      index = GenericPageTypeIndex.new(site, site.source, dir, page, page_type, do_related)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.static_files << index
    end

    def write_list(site, dir, pages, page_type)
      index = GenericPageTypeList.new(site, site.source, dir, pages, page_type)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.static_files << index
    end
  end

end