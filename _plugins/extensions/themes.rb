# Title: Themes Jekyll Extension
# Description: Add theme support to Jekyll
#
# Usage:
#
#  - Set the `theme` config key to a string in your `_config.yml`
#  - Create a folder named after your theme in `_themes`
#  - Create `includes` and `layouts` directories
#  - Add your overriden includes/layouts in the respective folders
#
# Sample Layout:
#
#  .
#  |-- _includes
#  |   `-- sidebar.markdown
#  |-- _layouts
#  |   |-- default.html
#  |   `-- post.html
#  `-- _themes
#      `-- minimal
#          |-- _includes
#          |   `-- sidebar.markdown
#          `-- _layouts
#          |   `-- post.html

module Jekyll
  class Site

    # Set layouts in the following order:
    #
    #  * ./_themes/default/_layouts
    #  * ./source/_themes/THEME_NAME/_layouts
    #
    def read_layouts(dir = '')
      recursive_read_layouts(File.join('..', '_themes', 'default', dir))
      recursive_read_layouts(File.join('_themes', self.config['theme'], dir)) if self.config.key?('theme')
    end

    def recursive_read_layouts(dir = '')
      base = File.join(self.source, dir, "_layouts")
      return unless File.exists?(base)
      entries = []
      Dir.chdir(base) { entries = filter_entries(Dir.glob('**/*.*')) }

      entries.each do |f|
        name = f.split(".")[0..-2].join(".")
        self.layouts[name] = Layout.new(self, base, f)
      end
    end

  end
end

module Jekyll

  class ThemeIncludeTag < Liquid::Tag
    def initialize(tag_name, file, tokens)
      super
      @file = file.strip
    end

    # Try includes in the following order:
    #
    # * source/_themes/THEME_NAME/_includes
    # * _themes/default/_includes
    #
    def render(context)
      if @file !~ /^[a-zA-Z0-9_\/\.-]+$/ || @file =~ /\.\// || @file =~ /\/\./
        return "Include file '#{@file}' contains invalid characters or sequences"
      end

      includes_dir = find_path(context)
      "Included file '#{@file}' not found in any _includes directories" if includes_dir.nil?

      Dir.chdir(includes_dir) do
        source = File.read(@file)
        partial = Liquid::Template.parse(source)
        context.stack do
          partial.render(context)
        end
      end
    end

    def find_path(context)
      site = context.registers[:site]

      dirs = [ File.join('..', '_themes', 'default') ]
      dirs.unshift(File.join('_themes', site.config['theme'])) if site.config.key?('theme')

      dirs.each do |dir|
        includes_dir = File.join(site.source, dir, '_includes')

        next if File.symlink?(includes_dir)

        Dir.chdir(includes_dir) do
          choices = Dir['**/*'].reject { |x| File.symlink?(x) }
          return includes_dir if choices.include?(@file)
        end
      end

      nil
    end
  end

end

Liquid::Template.register_tag('include', Jekyll::ThemeIncludeTag)
