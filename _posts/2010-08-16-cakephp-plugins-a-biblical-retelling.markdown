---
  title: CakePHP Plugins - A Biblical Retelling
  category: Code
  tags:
    - cakephp
    - plugins
  layout: post
---

I'm just going to list a few plugins I use and abuse on a daily basis, as well as things I've discovered but haven't found a use for but seem to be cool. YMMV, but things should mostly work in CakePHP 1.3

# Authentication and Authorization:
- [Debuggable's Authsome](http://github.com/felixge/cakephp-authsome): A no-nonsense replacement for AuthComponent. It doesn't handle redirection, just authentication to your app. On the plus side, it has `Authsome::get('fieldName')`, so retrieving logged-in user data anywhere is a breeze.
- [Jose Gonzalez's Sanction](http://github.com/josegonzalez/sanction): Something I cooked up, it works with Authsome and a simple config file to manage your application's permissions. It's cool in that there is a Helper that can be used to replace HtmlHelper and jacks into your Permission configuration file.
- [Nick Baker's Facebook](http://github.com/webtechnick/CakePHP-Facebook-Plugin): Facebook integration plugin. It can be used in conjunction with AuthComponent - and maybe Authsome? - to create a fully-functional Facebook authentication section. Neato-burrito, and I hope to use it some day. There is also a demo-site [here](http://facebook.webtechnick.com/).
- [Nick Baker's Gigya](http://github.com/webtechnick/CakePHP-Gigya-Plugin): Looks like a custom social network plugin that integrates with other networks on the service end with one api on your end. Haven't explored it too much, but the idea seems solid.
- [Jedt's Spark Plug](http://github.com/jedt/spark_plug): An awesome-sounding user management and admin section integrating Authsome with a simple ACL implementation. I haven't tried it, but it apparently uses my own Filter component to optionally filter permissions. Promising for sure, and I hope to have screenshots soon.
- [Valerij Bancer's PoundCake Control Panel](http://sourceforge.net/projects/bancer/): From the description: "admin panel for users and groups management, dynamic database driven ACL menus generation and management, permissions assignment to users and groups."  Cool
- [Travis Rowland's SuperAuth](http://github.com/Theaxiom/SuperAuth): I'll smack you if you want to implement Row-level ACL and don't use this. It's complete genius, and other than the missing tests - it's pretty advanced functionality, so I'd like tests - I wholly recommend it.
- [Mark Story's ACL Extras](http://github.com/markstory/acl_extras): Extra shit for ACL. Use ACL all day? Use this shell and make your life easier.
- [Mark Story's Menu Component](http://github.com/markstory/cakephp_menu_component): Build ACL-based Menu's for your application. Cool, no?
- [Matt Curry's Static User](http://github.com/mcurry/cakephp_static_user): Want to use `Authsome::get('fieldName')` syntax but you have too much AuthComponent code? This is an easy way to do the same, but with `User::get('fieldName')`. Try it out, it's pretty simple to implement.

# Searching and Pagination:
- [CakeDC's Search](http://github.com/CakeDC/Search): A proper, although slightly advanced, method of filtering paginated data. Written by the CakePHP expert's themselves. Maybe it needs more tests? ;)
- [Jose Gonzalez's Filter Plugin](http://github.com/josegonzalez/cakephp-filter-plugin): I had lots of help on this, but basically you can filter pagination via the Model data or related Model data. I've been doing lots of refactoring, and it still needs work, but I've heard of plenty of people using it in production, so it looks good on paper at least :)
- [Neil Crooke's Filter](http://github.com/neilcrookes/filter): This fucker is always trying to steal my plugin ideas. Haven't used it yet, but if it's anything like his Searchable plugin, it blows me out of the water. Meh.
- [Neil Crooke's Searchable](http://github.com/neilcrookes/searchable): Uses JSON to index searchable records. Pretty awesome, and I've used it on a couple sites, including CakePackages. Definitely something to look into.
- [Kalt's Search](http://github.com/kalt/search): I'm pretty sure Neil stole his idea from Kalt. Pretty sure.
- [Matt Curry's Pagination Recall](http://github.com/mcurry/pagination_recall): An undocumented plugin that allows one to save the current paginated page to the Session, which can then be retrieved whenever redirecting to the pagination action of that controller. Nifty, and something people ask for all the time.
- [Matt Curry's Yahoo Boss](http://github.com/mcurry/yahoo_boss): Implements Yahoo Boss searching within your application.

# File Uploading:
- [Vinicius Mendes' MeioUpload](http://github.com/jrbasso/MeioUpload): I've worked on this. The versioning is pretty silly atm, but I still say it's definitely usable.
- [Debuggable's TransloadIt plugin](http://github.com/felixge/cakephp-transload_it): A really rad way of uploading files to a NodeJs-based webservice that handles encoding, processing, and storage for you via Ajax. It's hot.
- [Michał Szajbe's UploadPack](http://github.com/szajbus/uploadpack): File Uploading with a Helper to output the stuff for you. It's dope, for damn sure. I actually prefer this over MeioUpload now, and I contribute to both and have been the "Maintainer" of both in some fashion over the past year.
- [Jose Gonzalez's Upload](http://github.com/josegonzalez/upload): I made an Upload plugin based on my work with MeioUpload and UploadPack. I haven't used it yet, but it's currently ~44% unit tested and once it is at 100%, I'll try it out and let you know ;)
- [David Perrson's Media](http://github.com/davidpersson/media): The grand-daddy of all CakePHP upload plugins. If this plugin doesn't do what you need it to do, the code hasn't been released as a CakePHP plugin. For advanced users only, but you won't be disappointed.

# Optimization
- [Frank de Graaf's Lazy Model](http://github.com/Phally/lazy_model): Make your model chain-loading lazy, and potentially speed up the enormous app you've been building. Definitely something to look into if you are in 1.2/1.3. CakePHP 2.0 will have this in the core, but since that's not out, Lazy Model is the next best thing.
- [Rafael Bandeiras' Linkable](http://github.com/Terr/linkable): Think of it as Containable Behavior's crazy best friend. You know, the one that is going to rule the world someday, but is busy in his basement writing SQL at the moment. Terr seems to have an updated version of it, so thats what I am linking to. Check it out.
- [Mark Story's Asset Compress](http://github.com/markstory/asset_compress): Compress your CSS and JS. This plugin rules, and no one other than the current lead developer of CakePHP could have such a gem chilling in his github profile.
- [Matt Curry's HTML Cache](http://github.com/mcurry/html_cache): Cache your pages to HTML. See a huge speedup. Great for static pages. Also has a Croogo hook, if you happen to be using Croogo CMS.
- [Matt Curry's URL Cache](http://github.com/mcurry/url_cache): This snarky motherfucker seems to have gems all over his Github profile. Cache your generated html urls to whatever caching system you use. Greatly speeds up requests on pages with a shit-ton of URLs to generate.
- [Matt Curry's Custom Find Types](http://github.com/mcurry/find): Definitely an easy way to build custom find types for your application, and easily customizable to add stuff like Caching or Filtering.

# Debugging
- [Mark Story's DebugKit](http://github.com/cakephp/debug_kit): Honestly, this man is a monster. Not only is he a JS-Ninja and CakePHP-bashing fiend, but he also draws incessantly and has time to hack on the most wonderful tool for debugging your CakePHP application. This is something you need to install NOW. You will love me later.
- [Joe Beeson's Referee](http://github.com/joebeeson/referee): "A CakePHP 1.3+ plugin for catching errors and exceptions and logging them." I think that's pretty cool, and so should you.
- [Matt Curry's Interactive](http://github.com/mcurry/interactive): A panel for DebugKit to interact with your app without refreshing the page. A great way to see what a particular query will perform.

# Useful Helpers
- [Graham Weldon's Gravatar](http://github.com/predominant/CakePHP-Goodies/blob/master/views/helpers/gravatar.php): Include your Gravatar's quickly and easily with this helper. Bakery Article [here](http://bakery.cakephp.org/articles/view/gravatar-helper).
- [Chris Your's CakeHelper](http://snipt.net/chrisyour/cakephp-content_for-capture-html-block-for-layout/): "Ever wanted a clean way to capture a block of HTML in your CakePHP view and use it later in your layout just like CakePHP uses $content_for_layout?" This helper is an implementation of Rails' content_for in CakePHP. Chawsome.
- [Joe Beeson's Analogue Helper](http://github.com/joebeeson/analogue): Sometimes you just need your helpers to pretend to be other, core helpers. Why? How the hell would I know! But now you can!
- [Graham Weldon's Auto-Javascript](http://github.com/predominant/CakePHP-Goodies/blob/master/views/helpers/auto_javascript.php): Graham is still an idiot and refuses to place his code in separate repositories :P . Also known as Predominant, he wrote this little helper to speed up javascript file inclusion within your templates. Bakery Article [here](http://bakery.cakephp.org/articles/view/automatic-javascript-includer-helper).

# Random Awesome-sauce
- [Carl Sutton's Google Plugin](http://github.com/dogmatic69/cakephp_google_plugin): Someone give this guy an award. Just a metric fuck-ton of Google Integration into CakePHP. You are all welcome.
- [Joe Beeson's Sassy](http://github.com/joebeeson/sassy): Admit it, you love SASS. Joe rules and built this sick plugin (and released it for you bastards) that integrates SASS into CakePHP.