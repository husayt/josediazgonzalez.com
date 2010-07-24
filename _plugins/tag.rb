module Jekyll

  class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')
      self.data['tag'] = tag
      related = []
      site.tags[tag].each do |post|
        post.tags.each do |rel| 
          related.push(rel) unless rel == tag && related.include?(rel)
        end
      end      
      self.data['related'] = related unless related.empty?
      tag_title_prefix = site.config['tag_title_prefix'] || 'Tags: '
      self.data['title'] = "#{tag_title_prefix}#{tag}"
    end
  end

  class TagGenerator < Generator
    safe true
    
    def generate(site)
      if site.layouts.key? 'tag_index'
        dir = site.config['tag_dir'] || 'tags'
        site.tags.keys.each do |tag|
          write_tag_index(site, File.join(dir, tag), tag)
        end
      end
    end
  
    def write_tag_index(site, dir, tag)
      index = TagIndex.new(site, site.source, dir, tag)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
    end
  end

end