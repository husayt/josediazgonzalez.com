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
- [Debuggable's Authsome](http://github.com/felixge/cakephp-authsome): A no-nonsense replacement for AuthComponent. It doesn't handle redirection, just authentication to your app. On the plus side, it has `Authsome::get('field')`, so retrieving logged-in user data anywhere is a breeze.
- [Jose Gonzalez's Sanction](http://github.com/josegonzalez/sanction): Something I cooked up, it works with Authsome and a simple config file to manage your application's permissions. It's cool in that there is a Helper that can be used to replace HtmlHelper and jacks into your Permission configuration file.
- [Nick Baker's Facebook](http://github.com/webtechnick/CakePHP-Facebook-Plugin): Facebook integration plugin. It can be used in conjunction with AuthComponent - and maybe Authsome? - to create a fully-functional Facebook authentication section. Neato-burrito, and I hope to use it some day. There is also a demo-site [here](http://facebook.webtechnick.com/).
- [Nick Baker's Gigya](http://github.com/webtechnick/CakePHP-Gigya-Plugin): Looks like a custom social network plugin that integrates with other networks on the service end with one api on your end. Haven't explored it too much, but the idea seems solid.
- [Jedt's Spark Plug](http://github.com/jedt/spark_plug): An awesome-sounding user management and admin section integrating Authsome with a simple ACL implementation. I haven't tried it, but it apparently uses my own Filter component to optionally filter permissions. Promising for sure, and I hope to have screenshots soon.
- [Valerij Bancer's PoundCake Control Panel](http://sourceforge.net/projects/bancer/): From the description: "admin panel for users and groups management, dynamic database driven ACL menus generation and management, permissions assignment to users and groups."  Cool
- [Travis Rowland's SuperAuth](http://github.com/Theaxiom/SuperAuth): I'll smack you if you want to implement Row-level ACL and don't use this. It's complete genius, and other than the missing tests - it's pretty advanced functionality, so I'd like tests - I wholly recommend it.

# Searching and Pagination:
- [CakeDC's Search](http://github.com/CakeDC/Search): A proper, although slightly advanced, method of filtering paginated data. Written by the CakePHP expert's themselves. Maybe it needs more tests? ;)
- [Jose Gonzalez's Filter Plugin](http://github.com/josegonzalez/cakephp-filter-plugin): I had lots of help on this, but basically you can filter pagination via the Model data or related Model data. I've been doing lots of refactoring, and it still needs work, but I've heard of plenty of people using it in production, so it looks good on paper at least :)
- [Neil Crooke's Filter](http://github.com/neilcrookes/filter): This fucker is always trying to steal my plugin ideas. Haven't used it yet, but if it's anything like his Searchable plugin, it blows me out of the water. Meh.
- [Neil Crooke's Searchable](http://github.com/neilcrookes/searchable): Uses JSON to index searchable records. Pretty awesome, and I've used it on a couple sites, including CakePackages. Definitely something to look into.
- [Kalt's Search](http://github.com/kalt/search): I'm pretty sure Neil stole his idea from Kalt. Pretty sure.

# File Uploading:
- [Vinicius Mendes' MeioUpload](http://github.com/jrbasso/MeioUpload): I've worked on this. The versioning is pretty silly atm, but I still say it's definitely usable.
- [Debuggable's TransloadIt plugin](http://github.com/felixge/cakephp-transload_it): A really rad way of uploading files to a NodeJs-based webservice that handles encoding, processing, and storage for you via Ajax. It's hot.
- [Michał Szajbe's UploadPack](http://github.com/szajbus/uploadpack): File Uploading with a Helper to output the stuff for you. It's dope, for damn sure. I actually prefer this over MeioUpload now, and I contribute to both and have been the "Maintainer" of both in some fashion over the past year.
- [Jose Gonzalez's Upload](http://github.com/josegonzalez/upload): I made an Upload plugin based on my work with MeioUpload and UploadPack. I haven't used it yet, but it's currently ~44% unit tested and once it is at 100%, I'll try it out and let you know ;)
- [David Perrson's Media](http://github.com/davidpersson/media): The grand-daddy of all CakePHP upload plugins. If this plugin doesn't do what you need it to do, the code hasn't been released as a CakePHP plugin. For advanced users only, but you won't be disappointed.