---
  title:       "Allow Subdirectories Apache"
  date:        2009-09-07 00:00
  description: Example .htaccess file for allowing custom subdirectories in your CakePHP application under Apache
  category:    Deployment
  tags:
    - cakephp
    - htaccess
    - apache
    - quicktip
  comments:    true
  sharing:     false
  published:   true
  layout:      post
---

``` lang:apache
<IfModule mod_rewrite.c>
    RewriteEngine On

    # Overrides
    RewriteCond %{REQUEST_URI} ^/?(development)/(.*)$
    RewriteRule ^.*$ - [L]

    # Cake rewrites here
    RewriteRule    ^$ app/webroot/    [L]
    RewriteRule    (.*) app/webroot/$1 [L]

</IfModule>
```
