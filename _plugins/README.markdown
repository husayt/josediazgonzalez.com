# Jekyll Plugins

I've created, ported, and copied quite a few plugins to my own blog, mainly for testing, but also for fun. Feel free to troll around and figure out what works and what doesn't for you.

Plugins will have readmes embedded at the top as comments. YMMV.

## Converters

For the time being, these converters do **NOT** work on anything in `_layouts`. This is a limitation in Jekyll which I hope to ~~hack~~ fix.

- `coffee`: Converts `.coffee` files to `.js`
- `haml`: Converts `.haml` files to `.html`
- `sass`: Converts `.sass` and `.scss` files to `.css`
- `styl`: Converts `.styl` files to `.css`
- `upcase`: Converts `.upcase` files to uppercase

## Extensions

- `iterator`: allows you to iterate over all tags/categories and then iterate over the posts in those tags/categories. You can use this to automatically generate a tag cloud and a category page listing. <em>e.g. [Tag Cloud on Sidebar](http://josediazgonzalez.com/categories/cakephp)</em>
- `liquid_exception_handler`: When creating there is a liquid exception, this will suppress the exception during jekyll's generation step. DANGEROUS
- `recursive_layouts`: Gives Jekyll the ability to support layouts inside of `_layouts` subdirectories. Required for generator plugins
- `post_filter`: Allows adding a `pre` and `post` filter step to post contents
- `themes`: Themes. For Jekyll.

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
- `atom`: creates an `atom.xml` feed
- `generic_index`: creates generic index pages, like `tag` and `category` pages. Automatically generate index pages for each of the site.config `index_pages`. Currently iterates over collections already in the site, meaning all you need to do to have index pages for tags and categories is add them to the `index_pages` `site.config` key. Creates specific collection pages from layouts in <em>_layouts</em> to specify what each page will look like. <em>e.g. [CakePHP](http://josediazgonzalez.com/categories/cakephp)</em>. Also creates a listing of all of a particular collection. <em>e.g. [Categories](http://josediazgonzalez.com/categories)</em>. If the yaml maps to a boolean `true`, related collection items will appear in `page.related`
- `post_type`: Allows you to create generic post type landing pages and sub-pages, like `portfolios` or `galleries`. Allows the creation of a series of posts based on a type. Useful if you want to create a portfolio or gallery from an `_post_types/gallery` or `_post_types/portfolio` directory.
- `sitemap`: creates a `sitemap.xml` file

## Tags

- `backtick`:
- `highlight`:
- `image`:
- `quote`: Allows the usage of blockquotes with attribution within your application by doing:

        {% blockquote John Hancock %}
        Content
        {% endblockquote %}
Also adds support for pullquotes:

        {% pullquote John Hancock %}
        Content
        {% endpullquote %}
- `rainbow`
- `raw`
- `render_time`

## Utilities

- `pygments_code`:
- `template_wrapper`:

# Errata

All plugins reside locally, in the `_plugins` folder, and in theory would be safe to run on Github. They may not be the best of Ruby code, since I am still but a Ruby apprentice, but they work fine for me :)