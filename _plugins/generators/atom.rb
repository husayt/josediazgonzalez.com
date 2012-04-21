require 'pathname'

module Jekyll
  class AtomIndex < Page
    alias_method :orig_write, :write

    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir  = dir
      @name = 'atom.xml'

      self.read_yaml(File.join(base, '_layouts', 'atom'), @name)
      self.process(@name)
    end
  end

  class AtomGenerator < Generator
    safe true
    priority :low

    def generate(site)
      site_folder = site.config['destination']
      Pathname.new(site_folder).mkdir unless File.directory?(site_folder)

      atom = AtomIndex.new(site, site.source, '/')
      atom.render(site.layouts, site.site_payload)
      atom.write(site.dest)
      site.static_files << atom
    end
  end
end