require 'pathname'

module Jekyll

  class Page
    def subfolder
      @dir
    end
  end

  class SitemapGenerator < Generator
    safe true
    priority :low

    def generate(site)
      site_folder = site.config['destination']
      Pathname.new(site_folder).mkdir unless File.directory?(site_folder)

      sitemap = SitemapIndex.new(site, site.source, '/')
      sitemap.render(site.layouts, site.site_payload)
      sitemap.write(site.dest)
      site.static_files << sitemap
    end
  end

  class SitemapIndex < Page
    alias_method :orig_write, :write

    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir  = dir
      @name = 'sitemap.xml'

      self.read_yaml(File.join(base, '_layouts', 'sitemap'), @name)
      self.data['pages'] = payload
      self.process(@name)
    end

    def payload
      pages = []

      @site.pages.each{ |page|
        path     = page.subfolder + '/' + page.name
        next unless File.exists?(@site.source + path)
        mod_date = File.mtime(@site.source + path)

        # Remove the trailing 'index.html' if there is one, and just output the folder name.
        path = path[0..-11] if path=~/index.html$/
        # Force file endings to be .html
        path = path.gsub(/\.(markdown|textile)$/i, '.html')

        pages << { 'url' => path, 'date' => mod_date.strftime("%Y-%m-%d")} unless path =~/error/
      }

      @site.site_payload['site']['posts'].each do |post|
        pages << { 'url' => post.url, 'date' => post.date.strftime("%Y-%m-%d")}
      end

      pages
    end
  end
end