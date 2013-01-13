---
  title:       "Simple JSON Layout"
  date:        2009-09-04 00:00
  description: Extremely simple JSON Layout for your application
  category:    Views
  tags:
    - cakephp
    - views
    - layout
    - json
    - quicktip
  comments:    true
  sharing:     false
  published:   true
  layout:      post
---

``` lang:php
header('Pragma: no-cache');
header('Cache-Control: no-store, no-cache, max-age=0, must-revalidate');
header('Content-Type: text/x-json');
echo $content_for_layout;
```
