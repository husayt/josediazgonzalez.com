require 'fileutils'
require 'find'

module Jekyll
  # The PortfolioIndex class creates a single portfolio page for the specified portfolio.
  class PortfolioIndex < Page
    
    # Initialize a new PortfolioIndex.
    #   +site+ is the Site
    #   +source+ is the String path to the <source>
    #   +dir+ is the relative path from the base directory to the portfolio folder.
    #   +name+ is the name of the portfolio to process.
    def initialize(site, source, dir, name, slug)
      @site = site
      @base = source
      @dir = dir

      self.read_yaml(@base, name)
      self.data['slug'] = slug
      self.data['is_portfolio'] = true

      if self.data.has_key?('date')
        # ensure Time via to_s and reparse
        self.date = Time.parse(self.data["date"].to_s)
      end

      if !self.data.has_key?('layout')
        self.data['layout'] = site.config['portfolio_layout'] || 'portfolio_index'
      end
      
      # Ignore the portfolio unless it has been marked as published.
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

  class PortfolioList < Page
    def initialize(site,  base, dir, portfolios)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'portfolio_list.html')
      self.data['portfolios'] = portfolios
      self.data['is_portfolio'] = true
    end
  end

  # Jekyll hook - the generate method is called by jekyll, and generates all the portfolio pages.
  class PortfolioGenerator < Generator
    safe true
    priority :low

    def generate(site)
      portfolio_list = []
      dir = site.config['portfolio_dir'] || 'portfolio'

      if site.layouts.key? 'portfolio_index'
        folder = site.config['portfolio_folder'] || '_portfolio'

        portfolios = self.get_files(folder)
        portfolios.each do |portfolio_path|
          portfolio_name = portfolio_path.sub(/^#{folder}\//, '\1')
          portfolio_dir = portfolio_path.sub(/^#{folder}\/([^\.]+)\..*/, '\1')

          portfolio = write_portfolio_index(site, File.join(site.source, folder), dir, portfolio_name, portfolio_dir)
          unless portfolio.nil?
            portfolio_list << portfolio
          end
        end
      end
      
      if portfolio_list.size > 1 and site.layouts.key? 'portfolio_list'
        write_portfolio_list(site, dir, portfolio_list)
      end
    end
    
    def write_portfolio_index(site, source, dir, portfolio, portfolio_dir)
      index = PortfolioIndex.new(site, source, File.join(dir, portfolio_dir), portfolio, portfolio_dir)
      if index.data['published']
        index.render(site.layouts, site.site_payload)
        index.write(site.dest)
        site.static_files << index
        return index
      end
      return nil
    end
    
    def write_portfolio_list(site, dir, portfolios)
      index = PortfolioList.new(site, site.source, dir, portfolios)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.static_files << index
    end
    
    # Gets a list of files in the _portfolio folder with a .yml extension.
    #
    # Return Array list of portfolio config files.
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