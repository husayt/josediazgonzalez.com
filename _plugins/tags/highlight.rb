# Title: HighlightTag
# Author: Brandon Mathis http://brandonmathis.com
# Description: Write highlights with semantic HTML5 <figure> and <figcaption> elements and optional syntax highlighting — all with a simple, intuitive interface.
#
# Syntax:
# {% highlight [title] [url] [link text] %}
# code snippet
# {% endhighlight %}
#
# For syntax highlighting, put a file extension somewhere in the title. examples:
# {% highlight file.sh %}
# code snippet
# {% endhighlight %}
#
# {% highlight Time to be Awesome! (awesome.rb) %}
# code snippet
# {% endhighlight %}
#
# Example:
#
# {% highlight Got pain? painreleif.sh http://site.com/painreleief.sh Download it! %}
# $ rm -rf ~/PAIN
# {% endhighlight %}
#
# Output:
#
# <figure class='code'>
# <figcaption><span>Got pain? painrelief.sh</span> <a href="http://site.com/painrelief.sh">Download it!</a>
# <div class="highlight"><pre><code class="sh">
# -- nicely escaped highlighted code --
# </code></pre></div>
# </figure>
#
# Example 2 (no syntax highlighting):
#
# {% highlight %}
# <sarcasm>Ooooh, sarcasm... How original!</sarcasm>
# {% endhighlight %}
#
# <figure class='code'>
# <pre><code>&lt;sarcasm> Ooooh, sarcasm... How original!&lt;/sarcasm></code></pre>
# </figure>
#
require './_plugins/utilities/pygments_code'
require './_plugins/utilities/template_wrapper'

module Jekyll

  class CodeBlock < Liquid::Block
    include HighlightCode
    include TemplateWrapper
    CaptionUrlTitle = /(\S[\S\s]*)\s+(https?:\/\/)(\S+)\s+(.+)/i
    CaptionUrl = /(\S[\S\s]*)\s+(https?:\/\/)(\S+)/i
    Caption = /(\S[\S\s]*)/
    def initialize(tag_name, markup, tokens)
      @title = nil
      @caption = nil
      @filetype = nil
      @highlight = true
      if markup =~ /\s*lang:(\w+)/i
        @filetype = $1
        markup = markup.sub(/lang:\w+/i,'')
      end
      if markup =~ CaptionUrlTitle
        @file = $1
        @caption = "<figcaption><span>#{$1}</span><a href='#{$2 + $3}'>#{$4}</a></figcaption>"
      elsif markup =~ CaptionUrl
        @file = $1
        @caption = "<figcaption><span>#{$1}</span><a href='#{$2 + $3}'>link</a></figcaption>"
      elsif markup =~ Caption
        @file = $1
        @caption = "<figcaption><span>#{$1}</span></figcaption>\n"
      end
      if @file =~ /\S[\S\s]*\w+\.(\w+)/ && @filetype.nil?
        @filetype = $1
      end
      super
    end

    def render(context)
      output = super
      source = "<figure class='code'>"
      source += @caption if @caption
      if @filetype
        source += " #{highlight(output, @filetype)}</figure>"
      else
        source += "#{tableize_code(output.lstrip.rstrip.gsub(/</,'&lt;'))}</figure>"
      end
      source = safe_wrap(source)
      source = context['pygments_prefix'] + source if context['pygments_prefix']
      source = source + context['pygments_suffix'] if context['pygments_suffix']
      source
    end
  end
end

Liquid::Template.register_tag('highlight', Jekyll::CodeBlock)