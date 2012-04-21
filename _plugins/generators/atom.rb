module Jekyll


  # Monkey-patch an accessor for a page's containing folder, since
  # we need it to generate the atom.xml.
  class Page
    def subfolder
      @dir
    end
  end


  # Sub-class Jekyll::StaticFile to allow recovery from unimportant exception
  # when writing the atom file.
  class StaticSitemapFile < StaticFile
    def write(dest)
      super(dest) rescue ArgumentError
      true
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

      # Write the contents of atom.xml.
      File.open(File.join(site_folder, 'atom.xml'), 'w') do |f|
        f.write(generate_header())
        f.write(generate_info(site))
        f.write(generate_content(site))
        f.write(generate_footer())
        f.close
      end

      # Add a static file entry for the zip file, otherwise Site::cleanup will remove it.
      site.static_files << Jekyll::StaticSitemapFile.new(site, site.dest, '/', 'atom.xml')
    end

    private

    # Returns the XML header.
    def generate_header
      '<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
'
    end

    def generate_info(site)
      config = {}
      config.merge(site.config['atom']) if site.config.key?('atom')
      config.merge(site.config)
      xmlschema = site.time.xmlschema

      "
 <title>#{config["title"]}</title>
 <link href=\"#{config["url"]}/atom.xml\" rel=\"self\"/>
 <link href=\"#{config["url"]}/\"/>
 <updated>#{xmlschema}</updated>
 <id>#{config["url"]}/</id>
 <author>
   <name>#{config["author"]}</name>
   <email>#{config["email"]}</email>
 </author>
"
    end

    # Returns a string containing the the XML entries.
    #
    #  +site+ is the global Site object.
    def generate_content(site)
      result   = ''
      base_url = site.config['url']

      posts = site.site_payload['site']['posts']
      for post in posts do
        result += entry(base_url, post)
      end

      result
    end

    # Returns the XML footer.
    def generate_footer
      "\n</feed>"
    end

    # Creates an XML entry from the given path and date.
    #
    #  +path+ is the URL path to the page.
    #  +date+ is the date the file was modified (in the case of regular pages), or published (for blog posts).
    def entry(base_url, post)
        # Force extensions to .html from markdown, textile.
        title = post.data["title"]
        url = base_url + post.url
        date = post.date.xmlschema
        content = post.data["description"]

      "
 <entry>
   <title>#{title}</title>
   <link href=\"#{url}\"/>
   <updated>#{date}</updated>
   <id>#{url}</id>
   <content type=\"html\">#{content}</content>
 </entry>
"
    end

    def truncatewords(input, words = 15, truncate_string = "...")
      if input.nil? then return end
      wordlist = input.to_s.split
      l = words.to_i - 1
      l = 0 if l < 0
      wordlist.length > l ? wordlist[0..l].join(" ") + truncate_string : input
    end

  end

end