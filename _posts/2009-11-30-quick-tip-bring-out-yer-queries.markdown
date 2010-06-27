---
  title: Quick Tip - Bring Out Yer Queries
  category: Snippets
  tags:
    - cakephp
    - quicktip
    - datasources
    - debugging
    - mysql
    - logging
  layout: post
---

When I was a lad... jk

Log your queries to find out wtf CakePHP is doing when it has 9 million blobs or is taking 34234 years to process (then use the 'contain' and 'fields' keys in your queries to trim it down.)

{% highlight php %}
<?php
// load lib
App::import('Datasource', 'DboSource');
App::import('Datasource', 'DboMysql');
/**
* @author RainChen @ Sun Feb 24 17:21:35 CST 2008
* @uses usage
* @link http://cakeexplorer.wordpress.com/2007/10/08/extending-of-dbosource-and-model-with-sql-generator-function/
* @access public
* @param parameter
* @return return
* @version 0.1
*/ 
class LogSource extends DboMysql {
	function logQuery($sql) {
		$return = parent::logQuery($sql);
		if(Configure::read('Cake.logQuery')) {
			$this->log("sql[$this->_queriesCnt]:".$sql, 'sql');
		}
		return $return;
	}
}
?>
{% endhighlight %}

Place that in `app/models/datasources/log_source.php`, set `datasource` key in your database configuration to `log`, and unset the `driver` key. I modified this datasource to work in 1.3, and the original code is from some random bakery article. There appears to be an issue with DebugKit, but whatever. You fix it, it worked well enough for my purposes (learning SQL).