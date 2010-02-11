---
  title: Allow Subdirectories Apache
  topics:
    - cakephp
    - htaccess
    - apache
    - quicktip
  layout: post
---

{% highlight apache %}
# Overrides
<IfModule mod_rewrite.c>
	RewriteEngine On
	RewriteCond %{REQUEST_URI} ^/?(development)/(.*)$
	RewriteRule ^.*$ - [L]
</IfModule>
# Cake rewrites here
<IfModule mod_rewrite.c>
	RewriteEngine on
	RewriteRule    ^$ app/webroot/    [L]
	RewriteRule    (.*) app/webroot/$1 [L]
</IfModule>
{% endhighlight %}