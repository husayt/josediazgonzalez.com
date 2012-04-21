module Jekyll

  class AtomIndex < Page
    alias_method :orig_write, :write

    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir  = dir
      @name = 'atom.xml'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts', 'atom'), @name)
    end
  end

  # Generates a atom.xml file containing URLs of all pages and posts.
  class AtomGenerator < Generator
    safe true
    priority :low

    # Generates the atom.xml file.
    #
    #  +site+ is the global Site object.
    def generate(site)
      # Create the destination folder if necessary.
      site_folder = site.config['destination']
      unless File.directory?(site_folder)
        p = Pathname.new(site_folder)
        p.mkdir
      end

      atom = AtomIndex.new(site, site.source, '/')
      atom.render(site.layouts, site.site_payload)
      atom.write(site.dest)
      site.static_files << atom
    end
  end
end