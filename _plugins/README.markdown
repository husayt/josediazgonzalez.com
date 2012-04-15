# Jekyll Plugins

I've created a bunch of plugins based on those included in [jekyll_ext](https://github.com/rfelix/jekyll_ext). I was sort of tired of having to install `jekyll_ext`, and since Jekyll has had a plugin system since around version 0.6 or so, I decided to migrate the plugins I use to Jekyll proper.

## Extensions

- `iterator`: allows you to iterate over all tags/categories and then iterate over the posts in those tags/categories. You can use this to automatically generate a tag cloud and a category page listing. <em>e.g. [Tag Cloud on Sidebar](http://josediazgonzalez.com/categories/cakephp)</em>
- `liquid_exception_handler`: When creating there is a liquid exception, this will suppress the exception during jekyll's generation step. DANGEROUS
- `post_filter`: Allows adding a `pre` and `post` filter step to post contents

## Filters

- `extended_filters`
  - `date_to_month`
  - `date_to_month_abbr`
  - `date_to_utc`
  - `html_truncatewords`
  - `preview`
  - `markdownify`

## Generators

- `archive`: creates archive pages by `year`, `year/month`, and `year/month/day`. Automatically generate archive pages for dates like 2010/, 2010/01/, and 2010/01/12 using files in <em>_layouts</em> to specify what each page will look like. <em>e.g. Posts for [January 2010](http://josediazgonzalez.com/2010/01)</em>
- `generic_index`: creates generic index pages, like `tag` and `category` pages. Automatically generate index pages for each of the site.config `index_pages`. Currently iterates over collections already in the site, meaning all you need to do to have index pages for tags and categories is add them to the `index_pages` `site.config` key. Creates specific collection pages from layouts in <em>_layouts</em> to specify what each page will look like. <em>e.g. [CakePHP](http://josediazgonzalez.com/categories/cakephp)</em>. Also creates a listing of all of a particular collection. <em>e.g. [Categories](http://josediazgonzalez.com/categories)</em>. If the yaml maps to a boolean `true`, related collection items will appear in `page.related`
- `post_type`: Allows you to create generic post type landing pages and sub-pages, like `_portfolios` or `_galleries`. Allows the creation of a series of posts based on a type. Useful if you want to create a portfolio or gallery from an `_galleries` or `_portfolios` directory.
- `sitemap`: creates a `sitemap.xml` file

## Tags

- `backtick`:
- `blockquote`:
- `highlight`:
- `image`:
- `rainbow`: Allows the usage of blockquotes with attribution within your application by doing:

        {% blockquote John Hancock %}
        Content
        {% endblockquote %}`
Also adds support for pullquotes:

        {% pullquote John Hancock %}
        Content
        {% endpullquote %}`

- `raw`

## Utilities

- `pygments_code`:
- `template_wrapper`:
- `recursive_layouts`: Gives Jekyll the ability to support layouts inside of `_layouts` subdirectories. Required for generator plugins

# Errata

All plugins reside locally, in the `_plugins` folder, and in theory would be safe to run on Github. They may not be the best of Ruby code, since I am still but a Ruby apprentice, but they work fine for me :)

Any undocumented plugins are not of my own creation. Please refer to their docblocks for more information.