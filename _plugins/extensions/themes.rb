# Title: Themes
#
# Add theme support to Jekyll
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
#
#
#

module Jekyll
  class Site
    alias_method :orig_read_layouts, :read_layouts

    def read_layouts(dir = '')
      orig_read_layouts(dir)
      return unless self.config.key?('theme')

      orig_read_layouts(File.join(dir, '_themes', self.config['theme']))
    end

  end
end

module Jekyll

  class ThemeIncludeTag < Liquid::Tag
    def initialize(tag_name, file, tokens)
      super
      @file = file.strip
    end

    def render(context)
      includes_dir = File.join(context.registers[:site].source, '_includes')

      if File.symlink?(includes_dir)
        return "Includes directory '#{includes_dir}' cannot be a symlink"
      end

      theme = nil
      use_theme = false

      if context.registers[:site].config.key?('theme')
        theme = context.registers[:site].config['theme']
        theme_includes_dir = File.join(context.registers[:site].source, '_themes', theme, '_includes')
        if File.exists?(theme_includes_dir)
          use_theme = true
          return "Includes directory '#{theme_includes_dir}' cannot be a symlink" if File.symlink?(theme_includes_dir)
        end
      end

      if @file !~ /^[a-zA-Z0-9_\/\.-]+$/ || @file =~ /\.\// || @file =~ /\/\./
        return "Include file '#{@file}' contains invalid characters or sequences"
      end

      choices = []
      if use_theme
        Dir.chdir(theme_includes_dir) do
          choices = Dir['**/*'].reject { |x| File.symlink?(x) }
        end
      end

      if choices.include?(@file)
        Dir.chdir(theme_includes_dir) do
          source = File.read(@file)
          partial = Liquid::Template.parse(source)
          context.stack do
            partial.render(context)
          end
        end
      else
        Dir.chdir(includes_dir) do
          choices = Dir['**/*'].reject { |x| File.symlink?(x) }
          unless choices.include?(@file)
            return "Included file '#{@file}' not found in _includes directory"
          end

          source = File.read(@file)
          partial = Liquid::Template.parse(source)
          context.stack do
            partial.render(context)
          end
        end
      end
    end
  end

end

Liquid::Template.register_tag('include', Jekyll::ThemeIncludeTag)
